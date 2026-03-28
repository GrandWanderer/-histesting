# Generating JavaScript Documentation

## Scope

This repository is a static HTML/CSS/JavaScript project. Its technical documentation is generated from frontend source code with `JSDoc`.

API documentation is not applicable here because the project has no backend endpoints, no server-side controllers, and no OpenAPI/Swagger surface.

## Install Dependencies

```bash
npm install
```

If you only need the exact locked toolchain used by CI, use:

```bash
npm ci
```

## Generate Documentation

Run:

```bash
npm run docs:generate
```

This command reads `jsdoc.config.json` and generates reference documentation from the JavaScript source files in `js/`.

## Output Location

Generated reference files are stored in:

```text
generated-docs/reference/
```

The generated entry page is:

```text
generated-docs/reference/index.html
```

## Rebuild After Code Changes

After changing documented JavaScript, rebuild the reference docs with:

```bash
npm run docs:clean
npm run docs:generate
```

The clean step removes old generated output so the new reference set is produced from a known state.

## Documentation Quality Checks

Documentation quality is checked in two ways:

- `npm run docs:check` runs ESLint with `eslint-plugin-jsdoc` rules against the JavaScript source;
- `npm test` runs executable examples that demonstrate the documented landing page behavior.

For the full local validation flow, run:

```bash
npm run check
```

## Archive Generated Documentation

After generating docs, create a submission archive with:

```bash
npm run docs:archive
```

The archive is written to:

```text
generated-docs/archive/reference-docs.tgz
```

## Publishing Notes

The repository already uses GitHub Pages for the landing page itself. The generated code reference can also be published separately if needed by uploading `generated-docs/reference/` as a Pages artifact in a dedicated docs workflow.

The current workflow keeps the site deployment and the developer reference documentation separate so the public landing page is not replaced by internal code docs.
