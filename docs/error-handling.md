# Frontend Error Handling

## Scope

This repository is a static browser-based site, so error handling is implemented on the client side only.

The solution is split between:

- [js/error-handler.js](/c:/Users/KV/source/repos/-histesting/js/error-handler.js) for capture and user-facing fallback UI;
- [js/i18n-errors.js](/c:/Users/KV/source/repos/-histesting/js/i18n-errors.js) for localized messages;
- [js/main.js](/c:/Users/KV/source/repos/-histesting/js/main.js) for logging realistic interaction failures;
- [404.html](/c:/Users/KV/source/repos/-histesting/404.html) for static not-found handling.

## Error Types Relevant To This Project

The implementation targets errors that make sense for a static landing page:

- missing DOM elements needed by enhancement scripts;
- invalid hash or missing section navigation target;
- failed lazy-load image or other resource loading issue;
- invalid logging configuration value through browser settings;
- unexpected runtime exception in frontend code;
- unhandled promise rejection in async UI logic;
- static page not found (`404.html`).

## Global Error Capture Strategy

The global error handler installs two browser-level listeners:

- `window.addEventListener('error', ..., true)` for runtime errors and resource-loading failures;
- `window.addEventListener('unhandledrejection', ...)` for unhandled promise rejections.

This means the page captures:

- uncaught JavaScript exceptions;
- unhandled rejected promises;
- loading failures for static assets such as images, scripts, or stylesheets.

## Unique Error Identifiers

Each reported error receives a unique identifier with the form:

```text
ERR-<time-based-part>-<random-part>
```

Example:

```text
ERR-m9v4k2-r4x8wm
```

These identifiers are:

- included in structured error logs;
- shown in the user-facing notification panel;
- included in the generated `mailto:` report link.

## Context Included In Error Records

Each captured error includes contextual data to support traceability:

- current page URL;
- current hash/section;
- browser user agent;
- browser language;
- session identifier;
- recent user action when available;
- trace identifier for the current operation;
- optional source, line, column, or resource URL depending on error type.

## Localized User-Facing Messages

The project supports localized error messages in:

- Ukrainian;
- English.

The selected locale is resolved from `navigator.language`.

Localized message groups include:

- generic error;
- resource loading error;
- unexpected error;
- action failed;
- not found / 404.

The messages intentionally avoid raw stack traces and instead explain:

- what happened in simple language;
- that the page may still continue working;
- what the user can try next;
- how to report the issue.

## User-Facing Runtime Error UI

For runtime errors, a visible notification panel is injected into the current page.

The panel includes:

- a short localized title;
- a friendly localized explanation;
- the generated error ID;
- a button to copy technical details;
- a `mailto:` link for reporting the issue;
- a dismiss button.

This approach is more realistic than a separate “runtime error page” because static hosting cannot redirect arbitrary in-page JavaScript failures to a server-rendered error document.

## Static 404 Handling

The repository now includes a custom [404.html](/c:/Users/KV/source/repos/-histesting/404.html) page.

It provides:

- localized not-found text;
- a direct link back to the main page;
- a report-problem email link;
- optional logging of the 404 page load when the browser scripts are available.

## How Users Can Report Problems

The current implementation uses a realistic static-site reporting path:

- a `mailto:` link to `kovalenko.vadim2004@gmail.com`.

The link pre-fills:

- the error ID;
- the current page URL;
- a short prompt asking the user to describe what happened.

This is appropriate for a small academic static site because it does not require backend infrastructure.

## Notes About Production Hosting

If the site were hosted in production behind Nginx or GitHub Pages, broader error tracking would still be external:

- frontend runtime capture would remain in the browser;
- static hosting could serve `404.html`;
- server logs or centralized observability would belong to the hosting layer, not to this repository’s application code.
