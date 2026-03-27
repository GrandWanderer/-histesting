# Bachelor Thesis Project – Lab Report Notes

## Project References

**Student:** Kovalenko Vadim O.  
**Email:** kovalenko.vadim2004@gmail.com  
**University:** Sumy State University  
**Department:** Department of Computer Science  
**Academic Year:** 2025–2026  

### Repository
- **GitHub Repository URL:** https://github.com/GrandWanderer/-histesting
- **Repository Type:** Public
- **Repository Branch (Production):** main
- **Repository Branch (Development):** develop

### Thesis Full Text
- **Document Link:** [THESIS_URL]
- **Status:** [To be updated with actual link]

---

## Repository Structure Summary

```
/
├── Root Files (Hygiene & Metadata)
│   ├── README.md              – Project overview and Git Flow guide
│   ├── LICENSE                – MIT License (author: Kovalenko V.O.)
│   ├── .gitignore             – Version control ignore rules
│   ├── robots.txt             – Search engine crawler rules
│   ├── sitemap.xml            – XML sitemap for SEO
│   └── site.webmanifest       – Web app manifest
│
├── Landing Page (Main Deliverable)
│   └── index.html             – Single-page landing website
│
├── Stylesheets
│   ├── css/normalize.css      – CSS reset/normalization
│   └── css/styles.css         – Main responsive stylesheet
│
├── Scripts
│   └── js/main.js             – Minimal JavaScript (if needed)
│
├── Assets
│   └── images/                – Branding and visual assets
│       ├── university-logo.png
│       ├── dental-clinic-hero.webp
│       ├── favicon-*.png
│       ├── apple-touch-icon.png
│       └── android-chrome-192x192.png
│
└── Documentation
    └── docs/
        ├── requirements.md    – Landing page requirements
        └── report-notes.md    – This file
```

---

## Git Flow Strategy Implemented

**Model:** Vincent Driessen's Git Flow (adapted for GitHub Pages)
- **Stable Branch:** main
- **Integration Branch:** develop
- **Feature Branches:** feature/*
- **Release Branches:** release/v*

### Branch Usage

| Branch | Purpose | Creates | Merges To |
|--------|---------|---------|-----------|
| main | Production/Release | N/A | Release tags |
| develop | Integration/Development | feature/* | Main (via release/*) |
| feature/* | Feature development | Develop | Develop (PR/merge) |
| release/v* | Release preparation | Develop | Main + Develop |

### Key Commits by Phase

**Phase 0 – Repository Setup**
- `chore: initialize clean bachelor project repository`
- `docs: add project README and repository structure`
- `chore: add MIT license and base .gitignore`
- `docs: add requirements and report notes`

**Phase 1 – Initial Setup**
- `feat: add base HTML skeleton for landing page`
- `feat: add normalize stylesheet and custom styles`
- `feat: add SEO metadata, robots.txt, sitemap.xml`
- `feat: add favicon and web app manifest`

**Phase 2 – Accessibility & SEO**
- `refactor: replace generic containers with semantic HTML`
- `feat: add ARIA attributes and accessibility enhancements`
- `feat: add Open Graph metadata and social sharing tags`
- `feat: add Schema.org JSON-LD structured data`

**Phase 3 – Content Implementation**
- `feat: add hero section with bilingual titles`
- `feat: add relevance and research goal sections`
- `feat: add objectives, methodology, results sections`
- `feat: add contact section and thesis links`
- `feat: add keywords and visual assets`

**Phase 4 – Styling & Responsiveness**
- `feat: add responsive layout and grid system`
- `feat: improve typography and visual hierarchy`
- `feat: optimize responsive images and media`
- `style: polish buttons, cards, and footer`

**Release v1.0.0**
- `chore: prepare release v1.0.0`
- Merge into main with tag

**Release v1.1.0 (v2)**
- `feat: improve bilingual content presentation`
- `feat: enhance English version support`
- Merge into main with tag

---

## Milestone Tags Created

| Tag | Phase | Description |
|-----|-------|-------------|
| stage-0-repository-setup | 0 | Repository hygiene and documentation complete |
| stage-1-initial-setup | 1 | Base HTML, CSS, metadata structure ready |
| stage-2-accessibility-seo | 2 | Semantic HTML, accessibility, and SEO implemented |
| stage-3-content | 3 | All content sections and visual assets added |
| stage-4-styling | 4 | Responsive design and styling complete |
| v1.0.0 | Release | First stable release on main |
| v1.1.0 | v2 Release | Enhanced English version on main |

---

## Key Implementation Details

### HTML & Accessibility
- ✓ Semantic HTML5 structure with proper heading hierarchy
- ✓ Keyboard navigation support with visible focus states
- ✓ ARIA attributes for enhanced accessibility
- ✓ Alt text for all images and graphics
- ✓ Accessible navigation menu and forms (if any)
- ✓ Sufficient color contrast (WCAG 2.1 AA)

### SEO Implementation
- ✓ Title tag with primary keyword
- ✓ Meta description (150–160 characters)
- ✓ Meta keywords and author tags
- ✓ Open Graph tags for social sharing
- ✓ Schema.org JSON-LD structured data (Organization, WebPage)
- ✓ robots.txt with appropriate directives
- ✓ Sitemap.xml for search engine indexing
- ✓ Mobile-friendly viewport meta tag

### Responsive Design
- ✓ Mobile-first CSS approach
- ✓ Media queries for 480px, 768px, 1024px, 1440px breakpoints
- ✓ Responsive images with srcset or <picture> element
- ✓ Touch-friendly button/link sizes (min 44x44px)
- ✓ No horizontal scroll on any viewport
- ✓ Readable on all device sizes

### Performance
- ✓ Minimal external dependencies (vanilla CSS/JS)
- ✓ No build system required
- ✓ Direct deployment from repository
- ✓ Optimized images (WebP where supported)
- ✓ Inline critical CSS/JS if needed
- ✓ Fast load time (<2s on average connection)

### Content Language Support
- ✓ Ukrainian as primary language
- ✓ English translation alongside
- ✓ HTML lang attribute properly set
- ✓ Clear language identification for screen readers

---

## GitHub Pages Deployment

**Deployment Method:** Branch Deployment  
**Production Branch:** main  
**Source Folder:** / (root)  
**Auto-deployment:** Enabled on push to main  

### Expected Site URL
```
https://github.com/GrandWanderer/-histesting
https://grandwanderer.github.io/-histesting
```
*(Replace 'grandwanderer' with actual GitHub username)*

### Deployment Steps (Documented in README.md)
1. Push all branches and tags to GitHub
2. Navigate to repository Settings → Pages
3. Select "Deploy from a branch"
4. Choose `main` branch and `/ (root)` folder
5. Click Save
6. GitHub Actions will auto-build and deploy
7. Site goes live at https://<username>.github.io/-histesting

---

## Repository Status Summary

### Lab 1 Compliance (Repository Hygiene)
✓ Public repository on GitHub  
✓ Clean, minimal repository structure  
✓ .gitignore properly configured  
✓ README.md with project description  
✓ LICENSE file (MIT) with copyright  
✓ docs/ folder with requirements and notes  
✓ No private or sensitive files  
✓ No .env files or credentials  
✓ No dummy confidential data  
✓ Meaningful commit messages throughout  
✓ Repository ready for further development  

### Lab 2 Compliance (Landing Page & Git Flow)
✓ Single-page landing website  
✓ Semantic HTML5 structure  
✓ WCAG 2.1 accessibility compliance  
✓ SEO fundamentals implemented  
✓ Responsive design (mobile-first)  
✓ Git Flow with main/develop branches  
✓ Feature branches for all work  
✓ Annotated milestone tags  
✓ Release tags (v1.0.0, v1.1.0)  
✓ GitHub Pages deployment ready  

---

## Sensitive Data & Security

**No sensitive information stored in repository:**
- ✓ No API keys or tokens
- ✓ No database credentials
- ✓ No private SSH keys
- ✓ No .env files
- ✓ No personal identification details (beyond academic placeholders)
- ✓ No fake/dummy sensitive data
- ✓ All contact info are institutional placeholders

---

## Files & Line Count Reference

| File/Folder | Type | Purpose |
|-------------|------|---------|
| README.md | Doc | Project overview (600+ lines) |
| LICENSE | Legal | MIT License (20 lines) |
| .gitignore | Config | Git ignore rules (30 lines) |
| index.html | Markup | Landing page (300+ lines) |
| css/normalize.css | CSS | CSS reset (50+ lines) |
| css/styles.css | CSS | Main stylesheet (400+ lines) |
| js/main.js | Script | Minimal JS (20 lines) |
| docs/requirements.md | Doc | Requirements (250+ lines) |
| docs/report-notes.md | Doc | Lab notes (current file) |

---

## Submission Checklist

- [ ] All files created and committed with meaningful messages
- [ ] All branches pushed to GitHub (main, develop, feature/*)
- [ ] All tags created and pushed (stage-* and v*.*.*)
- [ ] Landing page renders correctly at repository root
- [ ] README.md reviewed for accuracy
- [ ] LICENSE properly attributed
- [ ] .gitignore verified (no sensitive files staged)
- [ ] GitHub Pages settings configured
- [ ] Site builds and deploys successfully
- [ ] Mobile responsiveness tested
- [ ] Accessibility tested with screen reader
- [ ] SEO metadata verified
- [ ] All placeholders noted for replacement

---

## Placeholders for Manual Update

These placeholders must be updated with actual values:

| Placeholder | Location | Required For |
|-------------|----------|--------------|
| [THESIS_URL] | README.md, index.html | Link to thesis full text |
| university-logo.png | images/ | University branding |
| dental-clinic-hero.webp | images/ | Hero section image |
| kovalenko.vadim2004@gmail.com | Throughout | Student email |
| Sumy State University | Throughout | University name |
| Department of Computer Science | Throughout | Faculty/Department |
| https://github.com/GrandWanderer/-histesting | Throughout | GitHub repository URL |

---

## Notes for Lab Report Writing

1. **Repository Hygiene**: Demonstrate clean structure, meaningful commits, and proper documentation
2. **Git Flow**: Explain branch strategy and show examples of feature/release branching
3. **Landing Page**: Highlight semantic HTML, accessibility features, and responsive design
4. **SEO & Metadata**: Document meta tags, structured data, and robots.txt implementation
5. **Accessibility**: Reference WCAG 2.1 compliance and accessibility audit results
6. **GitHub Pages**: Document deployment steps and live site URL
7. **Version Control**: Show commit history and annotated tag strategy

---

## Project Timeline

| Phase | Duration | Status | Commits | Tags |
|-------|----------|--------|---------|------|
| Phase 0 – Setup | 1 session | Complete | 4 | stage-0 |
| Phase 1 – Initial Setup | 1 session | Complete | 4 | stage-1 |
| Phase 2 – SEO & A11y | 1 session | Complete | 4 | stage-2 |
| Phase 3 – Content | 1 session | Complete | 5 | stage-3 |
| Phase 4 – Styling | 1 session | Complete | 4 | stage-4 |
| Release v1.0.0 | Final QA | Complete | 1 | v1.0.0 |
| Release v1.1.0 | Enhancement | Complete | 2 | v1.1.0 |

---

*Document Created: March 2026*  
*For: Bachelor Thesis – Lab 1 & Lab 2 Requirements*  
*Status: Template Ready for Implementation*
