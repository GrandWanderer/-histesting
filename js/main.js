/**
 * Main JavaScript – Bachelor Thesis Landing Page
 * Minimal functionality for enhanced user experience
 */

'use strict';

// ========================================================================
// Smooth Scroll Behavior Enhancement
// ========================================================================

document.querySelectorAll('a[href^="#"]').forEach(link => {
    link.addEventListener('click', function(e) {
        const href = this.getAttribute('href');
        if (href !== '#' && document.querySelector(href)) {
            e.preventDefault();
            const target = document.querySelector(href);
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
                // Update focus for accessibility
                target.focus();
            }
        }
    });
});

// ========================================================================
// Keyboard Navigation Enhancement
// ========================================================================

document.addEventListener('keydown', function(e) {
    // Skip to main content with Shift+Alt+M
    if (e.shiftKey && e.altKey && e.key === 'M') {
        const main = document.querySelector('main');
        if (main) {
            main.focus();
            main.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    }
});

// ========================================================================
// Lazy Loading for Images
// ========================================================================

if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                if (img.dataset.src) {
                    img.src = img.dataset.src;
                    img.removeAttribute('data-src');
                }
                observer.unobserve(img);
            }
        });
    }, {
        rootMargin: '50px'
    });

    document.querySelectorAll('img[data-src]').forEach(img => {
        imageObserver.observe(img);
    });
} else {
    // Fallback for browsers without IntersectionObserver
    document.querySelectorAll('img[data-src]').forEach(img => {
        img.src = img.dataset.src;
    });
}

// ========================================================================
// Navigation Menu Active State
// ========================================================================

function updateActiveNavLink() {
    const navLinks = document.querySelectorAll('.nav-menu a');
    
    window.addEventListener('scroll', () => {
        let current = '';
        
        document.querySelectorAll('section[id]').forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            
            if (pageYOffset >= sectionTop - 100) {
                current = section.getAttribute('id');
            }
        });
        
        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href').slice(1) === current) {
                link.classList.add('active');
            }
        });
    });
}

updateActiveNavLink();

// ========================================================================
// Mobile Menu Toggle (if needed in future)
// ========================================================================

function initMobileMenu() {
    const navbar = document.querySelector('.navbar');
    const navMenu = document.querySelector('.nav-menu');
    
    if (!navbar || !navMenu) return;
    
    // Check if menu needs mobile toggle (can be added later)
    const updateMenuDisplay = () => {
        if (window.innerWidth <= 768) {
            // Mobile menu logic here if needed
        }
    };
    
    window.addEventListener('resize', updateMenuDisplay);
    updateMenuDisplay();
}

initMobileMenu();

// ========================================================================
// Form Focus States (if forms added in future)
// ========================================================================

document.addEventListener('DOMContentLoaded', () => {
    const inputs = document.querySelectorAll('input, textarea, select');
    
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.classList.add('focused');
        });
        
        input.addEventListener('blur', function() {
            this.classList.remove('focused');
        });
    });
});

// ========================================================================
// Analytics & Tracking (placeholder)
// ========================================================================

// Uncomment and configure when adding analytics service
/*
window.addEventListener('load', () => {
    // Track page load time
    const navStart = performance.timing.navigationStart;
    const navEnd = performance.timing.loadEventEnd;
    const totalLoadTime = (navEnd - navStart) / 1000; // in seconds
    console.log('Page load time: ' + totalLoadTime + ' seconds');
});
*/

// ========================================================================
// Console Messages (development)
// ========================================================================

console.log('%cBachelor Thesis Landing Page', 'font-size: 16px; font-weight: bold; color: #2c3e50;');
console.log('%cInformation System for Dental Clinic Management', 'font-size: 14px; color: #3498db;');
console.log('%cStudent: Kovalenko Vadim O. | University: Sumy State University', 'font-size: 12px; color: #7f8c8d;');
console.log('%cRepository: https://github.com/GrandWanderer/-histesting', 'font-size: 12px; color: #7f8c8d;');
