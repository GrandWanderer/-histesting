# Logging And Error Examples

## Example 1: Application Startup

```json
{
  "timestamp": "2026-03-28T08:25:00.103Z",
  "level": "INFO",
  "module": "main",
  "message": "Landing page application startup",
  "context": {
    "url": "https://grandwanderer.github.io/-histesting/",
    "hash": "",
    "language": "uk-UA",
    "userAgent": "Mozilla/5.0 ...",
    "configuredLogLevel": "INFO",
    "sessionId": "session-m9v4jz-3k7x8w2n"
  },
  "sessionId": "session-m9v4jz-3k7x8w2n",
  "traceId": "trace-m9v4k1-z8z7b6a2",
  "errorId": null
}
```

## Example 2: Recoverable Warning

```json
{
  "timestamp": "2026-03-28T08:26:41.907Z",
  "level": "WARNING",
  "module": "main.media",
  "message": "Lazy loading fallback activated",
  "context": {
    "url": "https://grandwanderer.github.io/-histesting/",
    "hash": "#overview",
    "language": "uk-UA",
    "userAgent": "Mozilla/5.0 ...",
    "reason": "IntersectionObserver unavailable"
  },
  "sessionId": "session-m9v4jz-3k7x8w2n",
  "traceId": "trace-m9v4mj-e7rq6n2a",
  "errorId": null
}
```

## Example 3: Structured Error Record

```json
{
  "timestamp": "2026-03-28T08:28:13.522Z",
  "level": "ERROR",
  "module": "error-handler",
  "message": "Unhandled runtime exception captured",
  "context": {
    "url": "https://grandwanderer.github.io/-histesting/",
    "hash": "#goal",
    "language": "uk-UA",
    "userAgent": "Mozilla/5.0 ...",
    "pageUrl": "https://grandwanderer.github.io/-histesting/",
    "pageHash": "#goal",
    "source": "js/main.js",
    "line": 214,
    "column": 17,
    "sessionId": "session-m9v4jz-3k7x8w2n",
    "recentAction": {
      "action": "anchor.click",
      "context": {
        "href": "#goal"
      },
      "at": "2026-03-28T08:28:13.015Z"
    }
  },
  "sessionId": "session-m9v4jz-3k7x8w2n",
  "traceId": "trace-m9v4nk-d8ea3q1s",
  "errorId": "ERR-m9v4nq-r4x8wm"
}
```

## Example 4: Invalid Navigation Target

```json
{
  "timestamp": "2026-03-28T08:30:04.090Z",
  "level": "WARNING",
  "module": "main.navigation",
  "message": "Navigation target was not found",
  "context": {
    "url": "https://grandwanderer.github.io/-histesting/",
    "hash": "",
    "language": "en-US",
    "userAgent": "Mozilla/5.0 ...",
    "href": "#missing-section"
  },
  "sessionId": "session-m9v4jz-3k7x8w2n",
  "traceId": "trace-m9v4qd-4xsk2v5h",
  "errorId": null
}
```

## Example 5: User-Facing Messages

Ukrainian runtime message:

```text
Сталася помилка
Сторінка продовжує працювати, але частина дії не виконалася. Спробуйте оновити сторінку або повторити дію ще раз.
Error ID: ERR-m9v4nq-r4x8wm
```

English runtime message:

```text
Something went wrong
The page is still available, but part of the action could not be completed. Try refreshing the page or repeating the action.
Error ID: ERR-m9v4nq-r4x8wm
```

## Example 6: 404 User-Facing Message

```text
Помилка 404
Сторінка, яку ви шукаєте, недоступна або була переміщена.
```

## Manual Inspection Commands

You can inspect browser-side log storage in devtools with:

```js
window.LandingPageLogger.getStoredLogs()
window.LandingPageLogger.exportLogs()
window.localStorage.getItem('landingPage.logLevel')
```
