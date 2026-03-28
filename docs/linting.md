# Linting and Static Analysis

## Selected tools and why they were chosen

- `ESLint` was selected for JavaScript because the project uses plain browser-side scripts and needs lightweight checks for correctness and maintainability.
- `Stylelint` was selected for CSS because the site is static, CSS-driven, and benefits from automated validation of invalid patterns and consistency rules.
- `TypeScript` was selected in JavaScript checking mode (`allowJs` + `checkJs`) to add static analysis without rewriting the project to `.ts` files.

## What code quality aspects matter most for this project

- Browser-safe JavaScript behavior is the highest priority because one incorrect DOM access can break navigation or accessibility behavior.
- Valid and maintainable CSS matters because the site is fully static and its presentation depends on stylesheet quality.
- Lightweight tooling matters because the repository is a plain HTML/CSS/JS landing page and should not gain unnecessary build complexity.
- Cross-platform Git hooks matter because contributors may work on Windows, where shell wrapper tools caused failures earlier.

## ESLint rules and explanation

- `no-unused-vars`: catches dead variables that make scripts harder to maintain.
- `no-undef`: prevents accidental use of undeclared names in browser code.
- `eqeqeq`: enforces strict equality to avoid coercion bugs.
- `curly`: requires braces for control flow blocks to reduce future editing mistakes.
- `semi`: keeps statement boundaries explicit.
- `quotes`: standardizes string quotes to single quotes.
- `no-var`: avoids function-scoped declarations in favor of block-scoped syntax.
- `prefer-const`: encourages immutable bindings when values do not change.
- `no-console`: configured as a warning so accidental debug output is visible without blocking all development.

## Stylelint rules and explanation

- `stylelint-config-standard`: provides a practical baseline for modern CSS projects.
- `alpha-value-notation`: keeps alpha values consistent.
- `color-function-notation`: enforces modern CSS color syntax.
- `declaration-block-no-redundant-longhand-properties`: helps avoid unnecessarily verbose declarations.
- `declaration-block-no-duplicate-properties`: catches overwritten properties such as duplicate `display` declarations.
- `media-feature-range-notation`: standardizes responsive breakpoint syntax.

The project intentionally disables `no-descending-specificity` and `value-keyword-case` because they created noise for this static-site stylesheet without improving correctness.

## Ignore rules

- `.eslintignore` excludes `node_modules/`, `images/`, `site-dist/`, `dist/`, and `build/`.
- `.stylelintignore` excludes the same generated and dependency paths, and also excludes `css/normalize.css`.
- `css/normalize.css` is treated as a vendor file and is not a good target for local style rewrites.
- `tsconfig.json` excludes generated output and dependency directories from static type checking.

## How to run linting

```bash
npm run lint:js
npm run lint:css
npm run lint
```

## How to run type checking

```bash
npm run typecheck
```

## Static typing

- `tsconfig.json` enables `allowJs`, `checkJs`, and `noEmit`.
- This keeps the project as plain JavaScript while still checking DOM usage and common type mistakes.
- The main improvements were explicit DOM element narrowing for `HTMLElement`, `HTMLAnchorElement`, and `HTMLImageElement`.

## Initial linting results

Baseline measurements were taken against the pre-fix source content from `HEAD`, using the final chosen rules.

- ESLint on `js/main.js`: 6 findings total.
- Stylelint on `css/styles.css`: 16 findings total.
- TypeScript JS-check on `js/main.js`: 6 findings total.
- Combined baseline: 28 findings total.

## Issues fixed

The following real issues were corrected:

- Removed an unused `sectionHeight` variable in `js/main.js`.
- Added missing braces to the mobile-menu width check in `js/main.js`.
- Replaced unsafe generic DOM access with checked `HTMLElement`, `HTMLAnchorElement`, and `HTMLImageElement` usage in `js/main.js`.
- Replaced `pageYOffset` usage with `window.scrollY` in `js/main.js`.
- Removed development `console.log` statements so `no-console` no longer reports warnings.
- Replaced long hex color values with short equivalents where appropriate in `css/styles.css`.
- Converted legacy `rgba(...)` values to modern `rgb(... / alpha)` notation in `css/styles.css`.
- Removed a duplicate `display` declaration from the `.btn` rule in `css/styles.css`.
- Updated responsive media queries to range notation syntax in `css/styles.css`.

Total fixed findings: 28 of 28.

## Remaining issues

- No remaining ESLint errors or warnings.
- No remaining Stylelint errors or warnings.
- No remaining TypeScript JS-check errors.

## How 50% threshold was measured

- Baseline total: 28 findings.
- 50% of 28 = 14 findings.
- The project exceeds the 50% threshold because 28 findings were fixed.

## How 90% threshold was measured

- Baseline total: 28 findings.
- 90% of 28 = 25.2 findings, which requires at least 26 resolved findings to meet or exceed the threshold.
- The project exceeds the 90% threshold because 28 findings were fixed.

## Native Git hooks without Husky

Husky was intentionally not used. Previous Husky-based setups caused shell and shebang compatibility problems on Windows/Git Bash, so this repository now uses native Git hooks through `.githooks/` and `core.hooksPath`.

- Hook file: `.githooks/pre-commit`
- Hook command: `npm run check`
- Line endings are enforced through `.gitattributes`:
  - `.githooks/*` uses LF
  - `*.sh` uses LF
  - `*.bat` uses CRLF

To configure hooks in a clone of this repository:

```bash
git config core.hooksPath .githooks
```

For Unix-like environments or Git Bash, the following command may also be useful:

```bash
chmod +x .githooks/pre-commit
```

## Build/workflow integration

- The existing GitHub Actions workflow now installs Node dependencies with `npm ci`.
- The validation job runs `npm run check` before static file validation.
- Deployment packaging excludes development-only files such as `node_modules`, `package.json`, `package-lock.json`, hook files, and lint/typecheck configuration files.

## How to test the pre-commit hook

```bash
git config core.hooksPath .githooks
npm run check
git commit --allow-empty -m "test: verify pre-commit hook"
```

If the checks fail, the commit will be blocked by the native Git hook.
