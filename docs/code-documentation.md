# Code Documentation Notes

## Purpose

This repository documents a static landing page, so its code documentation focuses on frontend behavior, DOM interactions, and contributor workflow rather than backend or API contracts.

The selected standard is `JSDoc`. It is a good fit because the project uses plain JavaScript and already relies on lightweight tooling instead of a framework or build pipeline.

## Frontend Behavior Model

The landing page script lives in `js/main.js` and exposes a small public browser API as `window.LandingPageApp`.

That API groups the progressive enhancements used by the site:

- smooth scrolling for in-page navigation links;
- keyboard navigation to the main content region;
- lazy loading for images declared with `data-src`;
- active navigation highlighting based on scroll position;
- responsive navigation hooks reserved for future mobile-menu work;
- focus-state helpers for future forms.

## Architectural Decisions

### Public API Instead Of Anonymous DOM Logic

The original DOM behavior was implemented as top-level event bindings. The documented version keeps the same user-facing behavior but organizes it behind named functions so contributors can:

- understand responsibilities more quickly;
- regenerate reference docs from the source;
- reuse functions in examples and tests;
- reinitialize behavior safely after markup changes.

### Testable Progressive Enhancement

The site remains fully usable without JavaScript. The script only enhances navigation, accessibility, and presentation details after the static HTML is already available.

That approach matches the project goals:

- no build step is required to serve the site;
- no runtime API dependency exists;
- DOM behavior is isolated to one file and easy to reason about.

### Documented Extension Points

`initMobileMenu()` remains intentionally lightweight. The current navigation is controlled by CSS, but the function is still part of the documented public surface so future contributors have a clear place to extend mobile navigation without scattering behavior across the file.

## Business Logic Summary

Even though the site is static, it still contains meaningful UI logic:

- hash links should scroll smoothly and move keyboard focus to the destination section;
- the currently visible section should be reflected in the navigation state;
- deferred images should load only when needed when the browser supports `IntersectionObserver`;
- browsers without `IntersectionObserver` should still load the images immediately;
- future form fields should get consistent focus styling without repeating class logic in markup.

## Non-Obvious Algorithms

The only small state-selection algorithm is the navigation highlighter. It works by:

1. collecting all sections with ids;
2. comparing the current `window.scrollY` value to each section offset;
3. activating the last section whose top edge is within 100 pixels of the viewport top.

That threshold avoids flicker near section boundaries and keeps the active state aligned with what a user is reading.

## Component Interactions

- `index.html` provides the semantic sections, navigation links, and deferred images.
- `css/styles.css` styles the `active`, `focused`, and responsive navigation states used by the script.
- `js/main.js` reads the document structure and attaches the enhancement behavior.
- `tests/main.test.js` acts as living documentation by demonstrating how the documented public API behaves in representative scenarios.

## API Documentation Note

API documentation is not applicable for this repository because the project is a static landing page with no backend endpoints, request handlers, or service contracts to describe.
