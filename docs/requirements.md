# Bachelor Thesis Landing Page Requirements

## Project Information

**Ukrainian Title:**  
Інформаційна система для управління стоматологічною клінікою

**English Title:**  
Information System for Dental Clinic Management

**Project Domain:**  
Web-oriented information system for dental clinic management

---

## Landing Page Goals

1. Present the bachelor thesis project professionally
2. Communicate the research problem and objectives
3. Showcase system functionality and expected outcomes
4. Provide contact information and repository access
5. Demonstrate modern web development and accessibility practices
6. Support a single-page, static website deployment

---

## Required Page Sections

1. **Header & Navigation** – Clear navigation menu
2. **Hero Section** – Bilingual thesis title and short summary
3. **Relevance/Problem Statement** – Why this system matters
4. **Research Goal** – Primary objective of the thesis
5. **Main Objectives** – 3–5 key research objectives
6. **Methodology** – Research and development approach
7. **Expected Results** – Outcomes and benefits
8. **Keywords** – Research domain keywords
9. **Contact Section** – Author and university information
10. **Footer** – Copyright, links, and institutional info

---

## Technical Requirements

### HTML & Semantic Structure
- Valid HTML5 markup
- Semantic elements: `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<footer>`
- Proper heading hierarchy (h1 → h6)
- No generic `<div>` wrappers where semantic elements apply

### Accessibility (WCAG 2.1 AA)
- Alt text for all images
- Keyboard navigation support (Tab, Enter, focus states)
- Accessible form fields with labels
- Sufficient color contrast (4.5:1 for text)
- Readable font sizes (minimum 14px body text)
- ARIA attributes where necessary (not overused)
- Screen reader friendly structure
- Clear focus indicators

### SEO Implementation
- `<title>` tag with primary keyword
- Meta description (150–160 characters)
- Meta keywords
- Author meta tag
- Open Graph tags (og:title, og:description, og:image, og:url)
- Twitter Card meta tags
- Schema.org JSON-LD (Organization and WebPage types)
- robots.txt with proper user-agent rules
- XML sitemap.xml with page entries
- Canonical URL if applicable

### Responsive Design
- Mobile-first CSS approach
- Breakpoints: 480px, 768px, 1024px, 1440px
- Responsive images with `<picture>` or srcset
- Touch-friendly buttons and links (min 44x44px)
- Readable on all screen sizes
- No horizontal scroll on mobile

### Performance
- Minimal external dependencies
- Fast load time (CSS/JS inline if small)
- Images optimized and modern formats (WebP)
- Lazy loading for below-fold images
- No render-blocking resources

### Web Manifest & Favicon
- site.webmanifest for PWA support
- Multiple favicon sizes (16x16, 32x32, 192x192, 512x512)
- apple-touch-icon.png for iOS
- Favicon links in `<head>`

---

## Content Requirements

### Bilingual Support
- Ukrainian as primary/default language
- English content presented alongside Ukrainian
- Clear language identification in HTML (lang attribute)
- Logical content organization (not page duplication)

### Text Content
- Clean, professional academic tone
- Ukrainian and English descriptions provided
- Facts-based, not marketing language
- Short paragraphs with clear visual separation
- Contact information with placeholders for personal data

### Visual Elements
- University logo (placeholder: `university-logo.png`)
- Hero image related to dental clinic (placeholder: `dental-clinic-hero.webp`)
- Professional color palette (academic, trustworthy)
- Consistent typography and spacing
- Optional: Icons for objectives or methodology

---

## Git Flow Requirements

Use Vincent Driessen's Git Flow model adapted for:
- **main** – production/stable branch (for releases)
- **develop** – integration/development branch
- **feature/** namespace – for feature branches
- **release/** namespace – for release preparation

### Branching Strategy
- Develop features on `feature/` branches
- Merge features into `develop` via pull requests
- Create release branches `release/v*` from `develop`
- Release branches are merged into `main` (tagged) and back into `develop`
- Use annotated tags (git tag -a) for releases

### Commit Discipline
- Descriptive, lowercase commit messages
- Format: `type: brief description`
  - `feat:` new feature
  - `refactor:` code restructuring
  - `docs:` documentation
  - `style:` styling/CSS
  - `fix:` bug fix
  - `chore:` maintenance
- One logical change per commit
- Reference section/feature in message when clear

---

## Release & Versioning

### Semantic Versioning
- Format: MAJOR.MINOR.PATCH (e.g., v1.0.0, v1.1.0)
- v1.0.0 – First stable release with complete landing page
- v1.1.0 – Enhanced bilingual/English version (v2)

### Annotated Tags
Create annotated tags at key milestones:
- `stage-0-repository-setup` – Phase 0 complete
- `stage-1-initial-setup` – Phase 1 complete
- `stage-2-accessibility-seo` – Phase 2 complete
- `stage-3-content` – Phase 3 complete
- `stage-4-styling` – Phase 4 complete
- `v1.0.0` – First release
- `v1.1.0` – Second release

---

## Lab Alignment

### LAB 1 – Repository Hygiene
✓ Public repository on GitHub  
✓ Clean minimal structure (no clutter)  
✓ .gitignore configured  
✓ README.md with description  
✓ LICENSE file (MIT)  
✓ docs/ folder with requirements  
✓ No private/sensitive files  
✓ Meaningful commit messages  

### LAB 2 – Landing Page & Git Flow
✓ Static one-page website  
✓ Semantic HTML5 and accessibility  
✓ SEO fundamentals  
✓ Responsive design  
✓ Git Flow implementation  
✓ Annotated milestone tags  
✓ GitHub Pages deployment ready  

---

## Constraints & Best Practices

- **No dependencies:** Plain HTML, CSS, minimal vanilla JS
- **No secrets:** No .env files, API keys, or sensitive data
- **No build step:** Direct deployment from repository
- **No heavy frameworks:** Keep it lightweight (static site)
- **Cross-browser:** Support Chrome, Firefox, Safari, Edge
- **Mobile-first:** Design starting from mobile, scale up
- **Academic tone:** Professional, formal, research-focused language

---

## Deployment Target

**Platform:** GitHub Pages  
**Branch:** main  
**Folder:** / (root)  
**URL Format:** `https://<username>.github.io/-histesting`

---

Last Updated: March 2026  
Lab Assignment: BA Thesis – Information System Development
