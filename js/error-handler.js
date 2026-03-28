/**
 * @file Global browser error handling and user-facing fallback UI.
 */

'use strict';

(function bootstrapErrorHandler(globalObject) {
    const runtimeWindow = /** @type {*} */ (globalObject);
    const logger = runtimeWindow.LandingPageLogger;
    const messageService = runtimeWindow.LandingPageErrorMessages;
    const REPORT_EMAIL = 'kovalenko.vadim2004@gmail.com';

    if (!logger || !messageService) {
        return;
    }

    function createErrorId() {
        return `ERR-${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 8)}`;
    }

    function getLocaleMessages() {
        const language = globalObject.navigator && globalObject.navigator.language
            ? globalObject.navigator.language
            : 'en';
        return messageService.getMessages(language);
    }

    function getEnvironmentContext() {
        return {
            pageUrl: globalObject.location && globalObject.location.href ? globalObject.location.href : '',
            pageHash: globalObject.location && globalObject.location.hash ? globalObject.location.hash : '',
            userAgent: globalObject.navigator && globalObject.navigator.userAgent ? globalObject.navigator.userAgent : '',
            language: globalObject.navigator && globalObject.navigator.language ? globalObject.navigator.language : '',
            sessionId: logger.sessionId,
            recentAction: logger.getRecentAction()
        };
    }

    function toPlainErrorDetails(details) {
        return JSON.stringify(details, null, 2);
    }

    function copyText(text) {
        if (globalObject.navigator && globalObject.navigator.clipboard && globalObject.navigator.clipboard.writeText) {
            return globalObject.navigator.clipboard.writeText(text);
        }

        return Promise.resolve();
    }

    function ensureUiContainer() {
        const documentRef = globalObject.document;
        const existingContainer = documentRef.getElementById('app-error-notifications');

        if (existingContainer) {
            return existingContainer;
        }

        const container = documentRef.createElement('section');
        container.id = 'app-error-notifications';
        container.className = 'app-error-notifications';
        container.setAttribute('aria-live', 'polite');
        container.setAttribute('aria-label', 'Application error notifications');
        documentRef.body.appendChild(container);
        return container;
    }

    function createReportLink(errorId) {
        const subject = encodeURIComponent(`Landing page issue report: ${errorId}`);
        const body = encodeURIComponent([
            `Error ID: ${errorId}`,
            `Page: ${globalObject.location && globalObject.location.href ? globalObject.location.href : ''}`,
            '',
            'Please describe what you were doing before the problem happened:'
        ].join('\n'));

        return `mailto:${REPORT_EMAIL}?subject=${subject}&body=${body}`;
    }

    function showUserMessage(options) {
        const documentRef = globalObject.document;
        const messages = getLocaleMessages();
        const container = ensureUiContainer();
        const panel = documentRef.createElement('article');
        const details = toPlainErrorDetails(options.details);
        const title = options.title || messages.genericErrorTitle;
        const message = options.message || messages.genericErrorMessage;

        panel.className = 'app-error-panel';
        panel.setAttribute('role', 'alert');
        panel.innerHTML = `
            <h2 class="app-error-panel__title">${title}</h2>
            <p class="app-error-panel__message">${message}</p>
            <p class="app-error-panel__meta">Error ID: <code>${options.errorId}</code></p>
            <div class="app-error-panel__actions">
                <button type="button" class="app-error-panel__button" data-action="copy">${messages.copyDetails}</button>
                <a class="app-error-panel__button app-error-panel__button--link" href="${createReportLink(options.errorId)}">${messages.reportProblem}</a>
                <button type="button" class="app-error-panel__button app-error-panel__button--secondary" data-action="dismiss">${messages.dismiss}</button>
            </div>
        `;

        const copyButton = panel.querySelector('[data-action="copy"]');
        const dismissButton = panel.querySelector('[data-action="dismiss"]');

        if (copyButton instanceof HTMLButtonElement) {
            copyButton.addEventListener('click', () => {
                copyText(details).then(() => {
                    copyButton.textContent = messages.detailsCopied;
                });
            });
        }

        if (dismissButton instanceof HTMLButtonElement) {
            dismissButton.addEventListener('click', () => {
                panel.remove();
            });
        }

        container.appendChild(panel);
    }

    function buildDetails(errorId, category, error, context, traceId) {
        return {
            errorId,
            category,
            traceId,
            message: error && error.message ? error.message : '',
            stack: error && error.stack ? error.stack : '',
            context: {
                ...getEnvironmentContext(),
                ...(context || {})
            }
        };
    }

    /**
     * Reports an application error, logs it, and optionally shows a user-facing message.
     *
     * @param {Error|undefined|null} error Native error object when available.
     * @param {object} options Reporting options.
     * @returns {string} Unique error identifier.
     */
    function reportError(error, options) {
        const errorId = createErrorId();
        const traceId = options && options.traceId ? options.traceId : logger.startTrace('error-handler', 'error.reported');
        const category = options && options.category ? options.category : 'unexpectedError';
        const messages = getLocaleMessages();
        const details = buildDetails(errorId, category, error || null, options && options.context ? options.context : {}, traceId);
        const titleKey = `${category}Title`;
        const messageKey = `${category}Message`;

        logger.error('error-handler', options && options.logMessage ? options.logMessage : 'Runtime error captured', details.context, {
            traceId,
            errorId
        });

        if (!options || options.showUserMessage !== false) {
            showUserMessage({
                errorId,
                details,
                title: messages[titleKey] || messages.genericErrorTitle,
                message: messages[messageKey] || messages.genericErrorMessage
            });
        }

        return errorId;
    }

    function reportActionFailure(category, context) {
        return reportError(null, {
            category: category || 'actionFailed',
            context,
            logMessage: 'User-facing action failed'
        });
    }

    function handleResourceError(event) {
        const target = event.target;

        if (!target || target === globalObject) {
            return;
        }

        const tagName = target.tagName ? target.tagName.toLowerCase() : 'unknown';
        const sourceUrl = target.currentSrc || target.src || target.href || '';

        reportError(null, {
            category: 'resourceLoadError',
            context: {
                resourceTag: tagName,
                resourceUrl: sourceUrl
            },
            logMessage: 'Static resource failed to load',
            showUserMessage: tagName === 'img'
        });
    }

    function handleRuntimeError(event) {
        if (event.target && event.target !== globalObject) {
            handleResourceError(event);
            return;
        }

        const error = event.error instanceof Error ? event.error : new Error(event.message || 'Unknown runtime error');
        reportError(error, {
            category: 'unexpectedError',
            context: {
                source: event.filename || '',
                line: event.lineno || 0,
                column: event.colno || 0
            },
            logMessage: 'Unhandled runtime exception captured'
        });
    }

    function handleUnhandledRejection(event) {
        const reason = event.reason instanceof Error
            ? event.reason
            : new Error(typeof event.reason === 'string' ? event.reason : 'Unhandled promise rejection');

        reportError(reason, {
            category: 'unexpectedError',
            context: {
                rejection: String(event.reason)
            },
            logMessage: 'Unhandled promise rejection captured'
        });
    }

    function installGlobalHandlers() {
        globalObject.addEventListener('error', handleRuntimeError, true);
        globalObject.addEventListener('unhandledrejection', handleUnhandledRejection);
        logger.info('error-handler', 'Global error handlers installed', {
            handlers: ['error', 'unhandledrejection']
        });
    }

    runtimeWindow.LandingPageErrorHandler = {
        getEnvironmentContext,
        installGlobalHandlers,
        reportActionFailure,
        reportError
    };
}(window));
