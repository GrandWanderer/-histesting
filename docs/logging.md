# Frontend Logging

## Chosen Approach

This project uses a lightweight browser-side logging module in [js/logger.js](/c:/Users/KV/source/repos/-histesting/js/logger.js).

The approach is intentionally simple because the repository is a static HTML/CSS/JavaScript site:

- logging happens in the browser only;
- no backend log collector is implemented in application code;
- logs are written to the browser console and to `localStorage`;
- the logger adds session and trace identifiers for correlation;
- a small extension hook is left in place through `registerHandler()` for future remote integrations.

## Log Levels

The project supports these levels:

- `DEBUG` for detailed initialization and interaction diagnostics;
- `INFO` for normal lifecycle events such as startup and successful actions;
- `WARNING` for fallback activation or recoverable issues;
- `ERROR` for captured failures and exceptions;
- `CRITICAL` for severe failures that would threaten core page usability.

## When Each Level Is Used

- `DEBUG`: module binding, section activation changes, image lazy-load progress.
- `INFO`: logger startup, application startup, successful navigation actions.
- `WARNING`: invalid navigation target, missing DOM dependencies, lazy-load fallback activation.
- `ERROR`: runtime exceptions, resource load failures, unhandled promise rejections, failed actions.
- `CRITICAL`: reserved for severe unrecoverable frontend failures if they are added later.

## Log Record Format

Each log record uses a structured format:

```json
{
  "timestamp": "2026-03-28T08:30:15.200Z",
  "level": "ERROR",
  "module": "error-handler",
  "message": "Unhandled runtime exception captured",
  "context": {
    "url": "https://grandwanderer.github.io/-histesting/",
    "hash": "#goal",
    "language": "uk-UA",
    "userAgent": "Mozilla/5.0 ...",
    "source": "js/main.js",
    "line": 214,
    "column": 17
  },
  "sessionId": "session-m9v4jz-3k7x8w2n",
  "traceId": "trace-m9v4k1-z8z7b6a2",
  "errorId": "ERR-m9v4k2-r4x8wm"
}
```

## How To Configure The Minimal Log Level

The minimal log level can be changed without rebuilding the site.

Supported mechanisms:

1. query parameter:

```text
?logLevel=debug
?logLevel=info
?logLevel=warning
?logLevel=error
?logLevel=critical
```

2. persisted browser setting in `localStorage`:

```text
landingPage.logLevel
```

Behavior:

- if `?logLevel=...` is present and valid, it takes priority;
- the valid query value is persisted into `localStorage`;
- if there is no query parameter, the logger uses the stored value;
- if no valid value is found, the default level is `INFO`.

## Active Handlers

The project currently uses two handlers:

- console handler for developer diagnostics in browser devtools;
- `localStorage` handler for persistent in-browser inspection and lab demonstration.

Optional helper support:

- `exportLogs()` returns the stored log buffer as formatted JSON;
- `clearStoredLogs()` clears the retained browser log history;
- `registerHandler()` allows a future remote adapter to be plugged in without rewriting the logger.

## Retention And Rotation Strategy

True server-side log rotation is not implemented because this is a static frontend project.

Instead, the browser logger uses a lightweight retention rule:

- only the most recent **150 log records** are kept in `localStorage`.

This is appropriate for a browser runtime because:

- storage is limited;
- the site has no file system access;
- long-term production retention belongs to external tooling, not to the static page itself.

## Logged Events In This Project

The implementation logs these realistic frontend events:

- logger startup;
- application startup;
- installation of global error handlers;
- initialization of navigation, media, layout, and form helpers;
- anchor-based navigation actions;
- keyboard shortcut activation;
- section activation changes during scrolling;
- lazy-load image handling and fallback activation;
- resource loading failures;
- user-facing action failures;
- uncaught exceptions and unhandled promise rejections.

## Production Notes

For real production monitoring on static hosting, centralized collection would be external. Examples include:

- Sentry browser SDK;
- LogRocket or similar session tools;
- a custom HTTPS endpoint outside this repository.

The current project does **not** pretend that such infrastructure already exists. It only prepares the code so a future handler could be attached through `registerHandler()`.
