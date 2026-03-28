import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import vm from 'node:vm';

class FakeClassList {
    constructor() {
        this.names = new Set();
    }

    add(name) {
        this.names.add(name);
    }

    remove(name) {
        this.names.delete(name);
    }

    toggle(name, force) {
        if (force === true) {
            this.add(name);
            return true;
        }

        if (force === false) {
            this.remove(name);
            return false;
        }

        if (this.names.has(name)) {
            this.remove(name);
            return false;
        }

        this.add(name);
        return true;
    }

    contains(name) {
        return this.names.has(name);
    }
}

class FakeElement {
    constructor(tagName, attributes = {}) {
        this.tagName = tagName.toUpperCase();
        this.attributes = new Map();
        this.dataset = {};
        this.listeners = new Map();
        this.classList = new FakeClassList();
        this.offsetTop = 0;
        this.focused = false;
        this.scrollCalls = [];
        this.defaultPrevented = false;

        Object.entries(attributes).forEach(([name, value]) => {
            this.setAttribute(name, value);
        });
    }

    addEventListener(type, listener) {
        const listeners = this.listeners.get(type) || [];
        listeners.push(listener);
        this.listeners.set(type, listeners);
    }

    dispatch(type, event = {}) {
        const listeners = this.listeners.get(type) || [];

        listeners.forEach(listener => {
            listener({
                ...event,
                type,
                currentTarget: event.currentTarget || this,
                target: event.target || this,
                preventDefault: event.preventDefault || (() => {
                    this.defaultPrevented = true;
                })
            });
        });
    }

    focus() {
        this.focused = true;
    }

    scrollIntoView(options) {
        this.scrollCalls.push(options);
    }

    setAttribute(name, value) {
        this.attributes.set(name, String(value));

        if (name === 'class') {
            String(value).split(/\s+/).filter(Boolean).forEach(className => {
                this.classList.add(className);
            });
        }

        if (name.startsWith('data-')) {
            const dataKey = name.slice(5).replace(/-([a-z])/g, (_, letter) => letter.toUpperCase());
            this.dataset[dataKey] = String(value);
        }
    }

    getAttribute(name) {
        return this.attributes.has(name) ? this.attributes.get(name) : null;
    }

    hasAttribute(name) {
        return this.attributes.has(name);
    }

    removeAttribute(name) {
        this.attributes.delete(name);

        if (name.startsWith('data-')) {
            const dataKey = name.slice(5).replace(/-([a-z])/g, (_, letter) => letter.toUpperCase());
            delete this.dataset[dataKey];
        }
    }
}

class FakeAnchorElement extends FakeElement {
    constructor(attributes = {}) {
        super('a', attributes);
    }
}

class FakeImageElement extends FakeElement {
    constructor(attributes = {}) {
        super('img', attributes);
        this.src = attributes.src || '';
    }
}

class FakeDocument {
    constructor(mapping) {
        this.mapping = mapping;
        this.listeners = new Map();
    }

    querySelector(selector) {
        const value = this.mapping[selector];

        if (Array.isArray(value)) {
            return value[0] || null;
        }

        return value || null;
    }

    querySelectorAll(selector) {
        const value = this.mapping[selector];
        return Array.isArray(value) ? value : value ? [value] : [];
    }

    addEventListener(type, listener) {
        const listeners = this.listeners.get(type) || [];
        listeners.push(listener);
        this.listeners.set(type, listeners);
    }

    dispatch(type, event = {}) {
        const listeners = this.listeners.get(type) || [];
        listeners.forEach(listener => {
            listener({
                ...event,
                type,
                preventDefault: event.preventDefault || (() => {})
            });
        });
    }
}

class FakeWindow {
    constructor(documentRef) {
        this.document = documentRef;
        this.listeners = new Map();
        this.scrollY = 0;
        this.innerWidth = 1024;
    }

    addEventListener(type, listener) {
        const listeners = this.listeners.get(type) || [];
        listeners.push(listener);
        this.listeners.set(type, listeners);
    }

    dispatch(type, event = {}) {
        const listeners = this.listeners.get(type) || [];
        listeners.forEach(listener => {
            listener({
                ...event,
                type,
                preventDefault: event.preventDefault || (() => {})
            });
        });
    }
}

function bootApp(customizeEnvironment) {
    const mainSection = new FakeElement('main');
    const firstSection = new FakeElement('section', { id: 'overview' });
    const secondSection = new FakeElement('section', { id: 'features' });
    firstSection.offsetTop = 0;
    secondSection.offsetTop = 400;

    const overviewLink = new FakeAnchorElement({ href: '#overview', class: 'nav-link' });
    const featuresLink = new FakeAnchorElement({ href: '#features', class: 'nav-link' });
    const lazyImage = new FakeImageElement({ 'data-src': 'images/hero.jpg' });
    const input = new FakeElement('input');
    const navbar = new FakeElement('nav', { class: 'navbar' });
    const navMenu = new FakeElement('ul', { class: 'nav-menu' });

    const documentRef = new FakeDocument({
        'a[href^="#"]': [overviewLink, featuresLink],
        '.nav-menu a': [overviewLink, featuresLink],
        'section[id]': [firstSection, secondSection],
        'img[data-src]': [lazyImage],
        'input, textarea, select': [input],
        '.navbar': navbar,
        '.nav-menu': navMenu,
        main: mainSection,
        '#overview': firstSection,
        '#features': secondSection
    });

    const windowRef = new FakeWindow(documentRef);

    if (typeof customizeEnvironment === 'function') {
        customizeEnvironment({
            documentRef,
            windowRef,
            mainSection,
            firstSection,
            secondSection,
            overviewLink,
            featuresLink,
            lazyImage,
            input,
            navMenu
        });
    }

    const scriptSource = readFileSync(resolve(process.cwd(), 'js', 'main.js'), 'utf8');
    const context = {
        window: windowRef,
        document: documentRef,
        HTMLElement: FakeElement,
        HTMLAnchorElement: FakeAnchorElement,
        HTMLImageElement: FakeImageElement
    };

    vm.createContext(context);
    vm.runInContext(scriptSource, context);

    return {
        app: windowRef.LandingPageApp,
        windowRef,
        documentRef,
        mainSection,
        firstSection,
        secondSection,
        overviewLink,
        featuresLink,
        lazyImage,
        input,
        navMenu
    };
}

function runCase(name, execute) {
    try {
        execute();
        console.log(`PASS ${name}`);
    } catch (error) {
        console.error(`FAIL ${name}`);
        console.error(error);
        process.exitCode = 1;
    }
}

runCase('exposes the documented public API and initializes responsive metadata', () => {
    const { app, navMenu } = bootApp();

    assert.ok(app);
    assert.equal(typeof app.init, 'function');
    assert.equal(typeof app.bindSmoothScrolling, 'function');
    assert.equal(typeof app.bindKeyboardNavigation, 'function');
    assert.equal(typeof app.initLazyLoading, 'function');
    assert.equal(typeof app.updateActiveNavLink, 'function');
    assert.equal(typeof app.initMobileMenu, 'function');
    assert.equal(typeof app.bindFormFocusStates, 'function');
    assert.equal(navMenu.dataset.mobileReady, 'false');
});

runCase('smooth scrolling prevents default navigation and focuses the target section', () => {
    const { overviewLink, firstSection } = bootApp();
    let prevented = false;

    overviewLink.dispatch('click', {
        currentTarget: overviewLink,
        preventDefault: () => {
            prevented = true;
        }
    });

    assert.equal(prevented, true);
    assert.equal(firstSection.focused, true);
    assert.equal(firstSection.scrollCalls.length, 1);
});

runCase('scroll tracking updates the active navigation item', () => {
    const { windowRef, overviewLink, featuresLink } = bootApp();

    windowRef.scrollY = 450;
    windowRef.dispatch('scroll');

    assert.equal(overviewLink.classList.contains('active'), false);
    assert.equal(featuresLink.classList.contains('active'), true);
});

runCase('lazy loading fallback copies data-src into src when IntersectionObserver is unavailable', () => {
    const { lazyImage } = bootApp();

    assert.equal(lazyImage.src, 'images/hero.jpg');
    assert.equal(lazyImage.dataset.src, undefined);
});

runCase('keyboard shortcut focuses the main content region', () => {
    const { documentRef, mainSection } = bootApp();

    documentRef.dispatch('keydown', {
        key: 'M',
        shiftKey: true,
        altKey: true
    });

    assert.equal(mainSection.focused, true);
    assert.equal(mainSection.scrollCalls.length, 1);
});

runCase('focus helpers add and remove the focused class on form controls', () => {
    const { input } = bootApp();

    input.dispatch('focus');
    assert.equal(input.classList.contains('focused'), true);

    input.dispatch('blur');
    assert.equal(input.classList.contains('focused'), false);
});

if (process.exitCode) {
    process.exit(process.exitCode);
}
