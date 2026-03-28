/**
 * @file Progressive enhancement entry point for the bachelor thesis landing page.
 * The script keeps the site fully static while adding smoother navigation,
 * keyboard accessibility, lazy-loaded media, and small form-state helpers.
 */

'use strict';

(function bootstrapLandingPage(globalObject) {
    const runtimeWindow = /** @type {*} */ (globalObject);
    const documentRef = globalObject.document;
    const windowRef = globalObject;
    const logger = runtimeWindow.LandingPageLogger || createNoopLogger();
    const errorHandler = runtimeWindow.LandingPageErrorHandler || createNoopErrorHandler();

    function createNoopLogger() {
        const noopTraceId = 'trace-disabled';

        return {
            sessionId: 'session-disabled',
            getConfiguredLevel: () => 'INFO',
            getRecentAction: () => null,
            setRecentAction: () => null,
            startTrace: () => noopTraceId,
            debug: () => null,
            info: () => null,
            warning: () => null,
            error: () => null,
            critical: () => null
        };
    }

    function createNoopErrorHandler() {
        return {
            installGlobalHandlers: () => null,
            reportActionFailure: () => null,
            reportError: () => null
        };
    }

    /**
     * Runtime dependencies used by the landing page behavior layer.
     *
     * @typedef {object} LandingPageDependencies
     * @property {Document} documentRef Browser document used for DOM queries and event binding.
     * @property {Window} windowRef Browser window used for viewport state and global events.
     */

    /**
     * Public browser API for the landing page enhancements.
     * The interface is exposed as `window.LandingPageApp` so contributors can
     * re-run specific behaviors after markup changes or use the API in examples.
     *
     * @typedef {object} LandingPageApp
     * @property {function(): void} init Initializes all progressive enhancement behaviors.
     * @property {function(): void} bindSmoothScrolling Enables smooth scrolling for same-page anchor links.
     * @property {function(): void} bindKeyboardNavigation Enables the `Shift + Alt + M` shortcut for the main content area.
     * @property {function(): void} initLazyLoading Activates `data-src` image loading with an Intersection Observer fallback.
     * @property {function(): void} updateActiveNavLink Synchronizes the active navigation link with the current scroll position.
     * @property {function(): void} initMobileMenu Reserves the responsive navigation hook used by future mobile-menu work.
     * @property {function(): void} bindFormFocusStates Adds and removes the `focused` helper class on form controls.
     */

    /**
     * Resolves an in-page anchor reference to a focusable HTML element.
     *
     * @param {Document} activeDocument Document that owns the target element.
     * @param {string} href Hash-based link target such as `#overview`.
     * @returns {HTMLElement|null} The matched element or `null` when the hash is empty or missing.
     */
    function resolveHashTarget(activeDocument, href) {
        if (typeof href !== 'string' || href === '#') {
            return null;
        }

        const target = activeDocument.querySelector(href);
        return target instanceof HTMLElement ? target : null;
    }

    /**
     * Moves focus to a section while keeping the DOM clean after the focus event.
     *
     * @param {HTMLElement} element Destination element that should receive focus.
     * @returns {void}
     */
    function focusSection(element) {
        const hadTabIndex = element.hasAttribute('tabindex');

        if (!hadTabIndex) {
            element.setAttribute('tabindex', '-1');
        }

        element.focus();

        if (!hadTabIndex) {
            element.addEventListener('blur', () => {
                element.removeAttribute('tabindex');
            }, { once: true });
        }
    }

    /**
     * Finds the section that should currently be represented as active in the navigation.
     *
     * @param {HTMLElement[]} sections Sections that participate in scroll tracking.
     * @param {number} scrollPosition Current vertical scroll offset.
     * @param {number} [activationOffset=100] Distance before a section reaches the viewport top when it becomes active.
     * @returns {string} The active section id, or an empty string when no section qualifies.
     * @example
     * const currentId = findCurrentSectionId(document.querySelectorAll('section[id]'), window.scrollY);
     */
    function findCurrentSectionId(sections, scrollPosition, activationOffset) {
        const resolvedOffset = typeof activationOffset === 'number' ? activationOffset : 100;
        let currentSectionId = '';

        sections.forEach(section => {
            if (scrollPosition >= section.offsetTop - resolvedOffset) {
                currentSectionId = section.getAttribute('id') || '';
            }
        });

        return currentSectionId;
    }

    /**
     * Copies the deferred image source into the real `src` attribute.
     *
     * @param {HTMLImageElement} image Image waiting to be loaded.
     * @returns {void}
     */
    function loadDeferredImage(image) {
        if (!image.dataset.src) {
            return;
        }

        image.src = image.dataset.src;
        image.removeAttribute('data-src');
    }

    /**
     * Updates the `focused` helper class used by the stylesheet.
     *
     * @param {HTMLElement} element Form control receiving or losing focus.
     * @param {boolean} isFocused Whether the element is currently focused.
     * @returns {void}
     */
    function setFocusedState(element, isFocused) {
        element.classList.toggle('focused', isFocused);
    }

    /**
     * Creates the public API that coordinates all landing page behaviors.
     *
     * @param {LandingPageDependencies} dependencies Runtime collaborators used by the app.
     * @returns {LandingPageApp} Documented public API for the landing page script.
     * @example
     * const app = window.LandingPageApp;
     * app.init();
     */
    function createLandingPageApp(dependencies) {
        const activeDocument = dependencies.documentRef;
        const activeWindow = dependencies.windowRef;

        /**
         * Enables smooth scrolling and focus management for local anchor navigation.
         * This keeps keyboard and assistive-technology users aligned with the visual scroll.
         *
         * @returns {void}
         * @example
         * window.LandingPageApp.bindSmoothScrolling();
         */
        function bindSmoothScrolling() {
            const hashLinks = activeDocument.querySelectorAll('a[href^="#"]');

            logger.debug('main.navigation', 'Binding smooth scrolling links', {
                count: hashLinks.length
            });

            hashLinks.forEach(link => {
                link.addEventListener('click', event => {
                    const currentLink = event.currentTarget;

                    if (!(currentLink instanceof HTMLAnchorElement)) {
                        return;
                    }

                    const href = currentLink.getAttribute('href') || '';
                    const traceId = logger.startTrace('main.navigation', 'anchor.click', {
                        href
                    });
                    const target = resolveHashTarget(activeDocument, href);

                    if (!target) {
                        logger.warning('main.navigation', 'Navigation target was not found', {
                            href
                        }, { traceId });
                        errorHandler.reportActionFailure('actionFailed', {
                            href,
                            reason: 'missing-section'
                        });
                        return;
                    }

                    event.preventDefault();
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                    focusSection(target);
                    logger.info('main.navigation', 'Anchor navigation completed', {
                        href,
                        targetId: target.id || ''
                    }, { traceId });
                });
            });
        }

        /**
         * Enables the `Shift + Alt + M` shortcut for jumping to the `<main>` region.
         * The shortcut mirrors the visible skip-navigation pattern even when the
         * pointer is not being used.
         *
         * @returns {void}
         * @example
         * window.LandingPageApp.bindKeyboardNavigation();
         */
        function bindKeyboardNavigation() {
            logger.debug('main.keyboard', 'Binding keyboard navigation shortcut');

            activeDocument.addEventListener('keydown', event => {
                if (!(event.shiftKey && event.altKey && event.key.toLowerCase() === 'm')) {
                    return;
                }

                const traceId = logger.startTrace('main.keyboard', 'shortcut.focus-main', {
                    key: event.key
                });
                const main = activeDocument.querySelector('main');

                if (!(main instanceof HTMLElement)) {
                    logger.error('main.keyboard', 'Main element is missing for keyboard shortcut', {}, { traceId });
                    errorHandler.reportActionFailure('actionFailed', {
                        shortcut: 'Shift+Alt+M',
                        reason: 'missing-main-element'
                    });
                    return;
                }

                focusSection(main);
                main.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
                logger.info('main.keyboard', 'Keyboard shortcut moved focus to main content', {}, { traceId });
            });
        }

        /**
         * Activates lazy loading for any image that uses a `data-src` attribute.
         * The behavior prefers `IntersectionObserver` and falls back to immediate
         * loading in older browsers, which keeps the page functional everywhere.
         *
         * @returns {void}
         * @example
         * window.LandingPageApp.initLazyLoading();
         */
        function initLazyLoading() {
            const deferredImages = activeDocument.querySelectorAll('img[data-src]');

            logger.debug('main.media', 'Initializing lazy loading', {
                deferredImages: deferredImages.length
            });

            if (!('IntersectionObserver' in activeWindow)) {
                deferredImages.forEach(image => {
                    if (image instanceof HTMLImageElement) {
                        image.addEventListener('error', () => {
                            const traceId = logger.startTrace('main.media', 'image.load-fallback-error', {
                                src: image.dataset.src || image.src
                            });

                            errorHandler.reportError(null, {
                                category: 'resourceLoadError',
                                context: {
                                    imageSrc: image.dataset.src || image.src,
                                    mode: 'fallback'
                                },
                                logMessage: 'Fallback image loading failed',
                                traceId
                            });
                        });

                        loadDeferredImage(image);
                    }
                });

                logger.warning('main.media', 'Lazy loading fallback activated', {
                    reason: 'IntersectionObserver unavailable'
                });
                return;
            }

            const observer = new IntersectionObserver((entries, currentObserver) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting && entry.target instanceof HTMLImageElement) {
                        const image = entry.target;
                        const traceId = logger.startTrace('main.media', 'image.lazy-load', {
                            src: image.dataset.src || image.src
                        });

                        image.addEventListener('error', () => {
                            errorHandler.reportError(null, {
                                category: 'resourceLoadError',
                                context: {
                                    imageSrc: image.currentSrc || image.src,
                                    mode: 'intersection-observer'
                                },
                                logMessage: 'Deferred image failed to load',
                                traceId
                            });
                        }, { once: true });

                        loadDeferredImage(image);
                        currentObserver.unobserve(image);
                        logger.debug('main.media', 'Deferred image loaded', {
                            src: image.currentSrc || image.src
                        }, { traceId });
                    }
                });
            }, {
                rootMargin: '50px'
            });

            deferredImages.forEach(image => {
                if (image instanceof HTMLImageElement) {
                    observer.observe(image);
                }
            });
        }

        /**
         * Keeps the navigation highlight aligned with the section currently near the
         * top of the viewport.
         *
         * Side effects:
         * - Registers a `scroll` listener on `window`.
         * - Adds and removes the `active` class on navigation anchors.
         *
         * @returns {void}
         * @example
         * window.LandingPageApp.updateActiveNavLink();
         */
        function updateActiveNavLink() {
            const navLinks = activeDocument.querySelectorAll('.nav-menu a');
            const sections = Array.from(activeDocument.querySelectorAll('section[id]')).filter(section => {
                return section instanceof HTMLElement;
            });
            let lastSectionId = '';

            if (!navLinks.length || !sections.length) {
                logger.warning('main.navigation', 'Navigation state tracking has missing DOM dependencies', {
                    navLinks: navLinks.length,
                    sections: sections.length
                });
            }

            const syncActiveLink = () => {
                const currentSectionId = findCurrentSectionId(sections, activeWindow.scrollY);

                navLinks.forEach(link => {
                    if (!(link instanceof HTMLAnchorElement)) {
                        return;
                    }

                    const isActive = (link.getAttribute('href') || '').slice(1) === currentSectionId;
                    link.classList.toggle('active', isActive);
                });

                if (currentSectionId && currentSectionId !== lastSectionId) {
                    lastSectionId = currentSectionId;
                    logger.debug('main.navigation', 'Active section changed', {
                        sectionId: currentSectionId
                    });
                }
            };

            activeWindow.addEventListener('scroll', syncActiveLink);
            syncActiveLink();
        }

        /**
         * Registers the responsive navigation hook kept for future mobile-menu work.
         * The current landing page uses CSS for its responsive layout, so the method
         * intentionally limits itself to a stable extension point.
         *
         * @returns {void}
         */
        function initMobileMenu() {
            const navbar = activeDocument.querySelector('.navbar');
            const navMenu = activeDocument.querySelector('.nav-menu');

            if (!(navbar instanceof HTMLElement) || !(navMenu instanceof HTMLElement)) {
                logger.warning('main.layout', 'Mobile navigation hook skipped due to missing DOM elements');
                return;
            }

            const updateMenuDisplay = () => {
                if (activeWindow.innerWidth <= 768) {
                    navMenu.dataset.mobileReady = 'true';
                    return;
                }

                navMenu.dataset.mobileReady = 'false';
            };

            activeWindow.addEventListener('resize', updateMenuDisplay);
            updateMenuDisplay();
            logger.debug('main.layout', 'Mobile navigation hook initialized', {
                mobileReady: navMenu.dataset.mobileReady
            });
        }

        /**
         * Adds a `focused` class to form controls so any future forms inherit a
         * consistent visual focus state without extra markup.
         *
         * @returns {void}
         * @example
         * window.LandingPageApp.bindFormFocusStates();
         */
        function bindFormFocusStates() {
            const formControls = activeDocument.querySelectorAll('input, textarea, select');

            logger.debug('main.forms', 'Binding focus state helpers', {
                controls: formControls.length
            });

            formControls.forEach(input => {
                if (!(input instanceof HTMLElement)) {
                    return;
                }

                input.addEventListener('focus', () => {
                    setFocusedState(input, true);
                });

                input.addEventListener('blur', () => {
                    setFocusedState(input, false);
                });
            });
        }

        /**
         * Initializes every progressive enhancement used by the landing page.
         * Call this when the page is ready or after replacing large parts of the DOM.
         *
         * @returns {void}
         * @example
         * window.LandingPageApp.init();
         */
        function init() {
            logger.info('main', 'Landing page application startup', {
                configuredLogLevel: logger.getConfiguredLevel(),
                sessionId: logger.sessionId
            });
            errorHandler.installGlobalHandlers();
            bindSmoothScrolling();
            bindKeyboardNavigation();
            initLazyLoading();
            updateActiveNavLink();
            initMobileMenu();
            bindFormFocusStates();
            logger.info('main', 'Landing page modules initialized');
        }

        return {
            init,
            bindSmoothScrolling,
            bindKeyboardNavigation,
            initLazyLoading,
            updateActiveNavLink,
            initMobileMenu,
            bindFormFocusStates
        };
    }

    const bootstrapWindow = /** @type {*} */ (windowRef);

    bootstrapWindow.LandingPageApp = createLandingPageApp({
        documentRef,
        windowRef
    });
    bootstrapWindow.LandingPageApp.init();
}(window));
