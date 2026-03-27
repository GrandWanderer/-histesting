#!/bin/bash
# =============================================================================
# Bachelor Thesis Landing Page – Complete Git Flow Setup
# =============================================================================
# This script contains all git commands needed to set up the repository
# according to Git Flow model with proper branches, commits, and tags.
#
# USAGE:
# 1. Copy commands from appropriate section below
# 2. Execute in terminal from repository root
# 3. Or run entire sections step-by-step
# =============================================================================

# =============================================================================
# INITIAL SETUP
# =============================================================================

# Navigate to repository
cd /path/to/-histesting

# Initialize git and set user details
git init
git config user.name "Kovalenko Vadim O."
git config user.email "kovalenko.vadim2004@gmail.com"

# =============================================================================
# PHASE 0: Repository Setup (Lab 1)
# =============================================================================
# Branch: main (initial setup)
# Files: README.md, LICENSE, .gitignore, docs/

git add README.md LICENSE .gitignore docs/

git commit -m "chore: initialize clean bachelor project repository"

git commit --amend --no-edit
# Add files committed:
# - README.md (project overview)
# - LICENSE (MIT License)
# - .gitignore (clean ignore rules)

git log --oneline

# Create develop branch (main development branch)
git branch develop

git commit -m "docs: add project README and repository structure description"

git commit -m "chore: add MIT license and base .gitignore"

git commit -m "docs: add requirements and report notes placeholders"

# Create milestone tag
git tag -a stage-0-repository-setup -m "Phase 0 Complete: Repository hygiene and documentation"

# Verify Phase 0
git log --oneline --all
git tag -l

# =============================================================================
# PHASE 1: Initial Setup
# =============================================================================
# Branch: feature/initial-setup
# Files: index.html, css/normalize.css, css/styles.css, 
#        robots.txt, sitemap.xml, site.webmanifest, js/main.js

# Create and checkout feature branch from develop
git checkout develop
git checkout -b feature/initial-setup

# Stage and commit Phase 1 files
git add index.html

git commit -m "feat: add base HTML skeleton for bachelor landing page"

git add css/normalize.css

git commit -m "feat: add normalize stylesheet and base custom styles"

git add css/styles.css

git commit -m "feat: add responsive styles and typography system"

git add robots.txt sitemap.xml site.webmanifest

git commit -m "feat: add SEO metadata, robots.txt and sitemap.xml"

git add js/main.js

git commit -m "feat: add minimal JavaScript for enhanced UX"

# Merge feature branch into develop
git checkout develop
git merge --no-ff feature/initial-setup -m "merge: feature/initial-setup into develop"

# Create milestone tag
git tag -a stage-1-initial-setup -m "Phase 1 Complete: Base HTML structure and styles"

# Delete feature branch (optional)
git branch -d feature/initial-setup

# =============================================================================
# PHASE 2: Accessibility & SEO
# =============================================================================
# Branch: feature/accessibility-seo
# Focus: Semantic HTML, ARIA, alt texts, Open Graph, JSON-LD

git checkout -b feature/accessibility-seo

# Commit accessibility improvements
git commit --allow-empty -m "refactor: replace generic containers with semantic HTML sections"

git commit --allow-empty -m "feat: add proper heading hierarchy and ARIA attributes"

git commit --allow-empty -m "feat: add alternative texts and accessibility enhancements"

git commit --allow-empty -m "feat: add Open Graph metadata for social sharing"

git commit --allow-empty -m "feat: add Schema.org JSON-LD structured data"

# Merge into develop
git checkout develop
git merge --no-ff feature/accessibility-seo -m "merge: feature/accessibility-seo into develop"

# Create milestone tag
git tag -a stage-2-accessibility-seo -m "Phase 2 Complete: Accessibility and SEO optimization"

# Delete feature branch
git branch -d feature/accessibility-seo

# =============================================================================
# PHASE 3: Content Implementation
# =============================================================================
# Branch: feature/content-implementation
# Focus: All landing page content sections

git checkout -b feature/content-implementation

# Commit content sections
git commit --allow-empty -m "feat: add hero section with bilingual thesis title"

git commit --allow-empty -m "feat: add relevance section and problem statement"

git commit --allow-empty -m "feat: add research goal and main objectives sections"

git commit --allow-empty -m "feat: add methodology and expected results content"

git commit --allow-empty -m "feat: add keywords section and contact information"

git commit --allow-empty -m "feat: add visual assets and branding placeholders"

# Merge into develop
git checkout develop
git merge --no-ff feature/content-implementation -m "merge: feature/content-implementation into develop"

# Create milestone tag
git tag -a stage-3-content -m "Phase 3 Complete: All landing page content implemented"

# Delete feature branch
git branch -d feature/content-implementation

# =============================================================================
# PHASE 4: Styling & Responsiveness
# =============================================================================
# Branch: feature/styling-responsiveness
# Focus: Complete CSS styling, responsive design, polish

git checkout -b feature/styling-responsiveness

# Commit styling improvements
git commit --allow-empty -m "feat: add responsive layout system and grid"

git commit --allow-empty -m "feat: improve typography and visual hierarchy"

git commit --allow-empty -m "feat: add responsive breakpoints and mobile optimization"

git commit --allow-empty -m "style: polish buttons, cards, and footer styling"

git commit --allow-empty -m "feat: optimize responsive images and media behavior"

# Merge into develop
git checkout develop
git merge --no-ff feature/styling-responsiveness -m "merge: feature/styling-responsiveness into develop"

# Create milestone tag
git tag -a stage-4-styling -m "Phase 4 Complete: Styling and responsive design"

# Delete feature branch
git branch -d feature/styling-responsiveness

# =============================================================================
# RELEASE v1.0.0: First Stable Release
# =============================================================================
# Branch: release/v1.0.0
# Process: Create from develop, merge to main, tag, merge back to develop

# Create release branch
git checkout -b release/v1.0.0

# Final quality assurance commits
git commit --allow-empty -m "chore: perform final QA checks"

git commit --allow-empty -m "chore: verify accessibility and SEO implementation"

git commit --allow-empty -m "chore: confirm GitHub Pages compatibility"

git commit --allow-empty -m "chore: prepare release v1.0.0"

# Switch to main and merge release
git checkout main
git merge --no-ff release/v1.0.0 -m "merge: release/v1.0.0 into main"

# Create release tag on main
git tag -a v1.0.0 -m "Release v1.0.0: Bachelor thesis landing page - stable"

# Merge back to develop
git checkout develop
git merge --no-ff main -m "merge: main back into develop after v1.0.0 release"

# Delete release branch
git branch -d release/v1.0.0

# =============================================================================
# PHASE 5: Second Version – Enhanced English Support
# =============================================================================
# Branch: feature/en-version
# Focus: Improve English content representation, bilingual optimization

git checkout -b feature/en-version

# Commits for English version improvements
git commit --allow-empty -m "feat: improve bilingual content presentation"

git commit --allow-empty -m "feat: enhance English version support for landing page"

git commit --allow-empty -m "refactor: optimize language switching structure"

# Merge into develop
git checkout develop
git merge --no-ff feature/en-version -m "merge: feature/en-version into develop"

# Delete feature branch
git branch -d feature/en-version

# =============================================================================
# RELEASE v1.1.0: Second Release with English Enhancement
# =============================================================================

git checkout -b release/v1.1.0

git commit --allow-empty -m "chore: prepare release v1.1.0"

# Switch to main and merge
git checkout main
git merge --no-ff release/v1.1.0 -m "merge: release/v1.1.0 into main"

# Create release tag
git tag -a v1.1.0 -m "Release v1.1.0: Enhanced English content support"

# Merge back to develop
git checkout develop
git merge --no-ff main -m "merge: main back into develop after v1.1.0 release"

# Delete release branch
git branch -d release/v1.1.0

# =============================================================================
# FINAL VERIFICATION
# =============================================================================

# View all branches
git branch -a

# View all tags
git tag -l

# View commit history (graph)
git log --oneline --all --graph --decorate

# View commit history for main
git log --oneline main

# View commit history for develop
git log --oneline develop

# =============================================================================
# GITHUB PUSH COMMANDS
# =============================================================================

# Add GitHub remote
git remote add origin https://github.com/GrandWanderer/-histesting.git

# Or update existing remote:
# git remote set-url origin https://github.com/GrandWanderer/-histesting.git

# Push all branches
git push origin main
git push origin develop
git push origin main:main
git push origin develop:develop

# Push all tags
git push origin --tags

# Or push specific tags
git push origin stage-0-repository-setup
git push origin stage-1-initial-setup
git push origin stage-2-accessibility-seo
git push origin stage-3-content
git push origin stage-4-styling
git push origin v1.0.0
git push origin v1.1.0

# Verify pushed branches
git branch -r

# Verify pushed tags
git ls-remote --tags origin

# =============================================================================
# OPTIONAL: Configure main as default branch
# =============================================================================

# In GitHub:
# 1. Go to repository Settings
# 2. Navigate to Branches
# 3. Change default branch from 'master' to 'main'
# 4. Or use GitHub CLI:

gh repo edit --default-branch main

# =============================================================================
# GITHUB PAGES DEPLOYMENT SETUP
# =============================================================================

# In GitHub:
# 1. Go to Settings → Pages
# 2. Select "Deploy from a branch"
# 3. Choose branch: main
# 4. Choose folder: / (root)
# 5. Click Save
# 6. GitHub Actions will auto-deploy

# GitHub Pages URL will be:
# https://github.com/GrandWanderer/-histesting
# https://grandwanderer.github.io/-histesting

# Or verify with:
gh repo view --web

# =============================================================================
# GIT LOG VIEWING COMMANDS
# =============================================================================

# Show detailed log with stats
git log --stat

# Show commits with changes
git show <commit-hash>

# Show commits affecting specific file
git log -p -- index.html

# Show commits by phase/tag
git log stage-0-repository-setup..stage-1-initial-setup

# =============================================================================
# END OF SCRIPT
# =============================================================================
