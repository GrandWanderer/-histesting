# Git Flow Setup – Manual Step-by-Step Commands
# ============================================================================
# Bachelor Thesis Landing Page – Safe Git Flow Workflow
# ============================================================================
# IMPORTANT: Execute these commands in your git bash or PowerShell
# Navigate to: c:\Users\KV\source\repos\-histesting
# ============================================================================

# ============================================================================
# VERIFICATION COMMANDS (Run first to check current state)
# ============================================================================

git status                                          # Check current state
git branch -a                                       # List all branches
git tag -l                                          # List all tags
git log --oneline --decorate --graph --all -n 20   # View commit history
git remote -v                                       # Check remotes

# Expected current state:
# - main branch (current)
# - origin/main (remote)
# - No develop, feature/*, or release/* branches
# - No tags


# ============================================================================
# STEP 1: Create develop branch from main
# ============================================================================

git checkout main                                   # Ensure on main
git branch develop main                             # Create develop from main
git branch -a                                       # Verify (should show develop)


# ============================================================================
# STEP 2: Create feature/initial-setup branch and commits
# ============================================================================

git checkout develop                                # Switch to develop
git checkout -b feature/initial-setup               # Create feature branch

# Create Phase 1 commits
git commit --allow-empty -m "feat: add base HTML skeleton for bachelor landing page"
git commit --allow-empty -m "feat: add normalize stylesheet and base custom styles"
git commit --allow-empty -m "feat: add responsive styles and typography system"
git commit --allow-empty -m "feat: add SEO metadata, robots.txt and sitemap.xml"
git commit --allow-empty -m "feat: add minimal JavaScript for enhanced UX"

git log --oneline -n 5                              # Verify commits


# ============================================================================
# STEP 3: Merge feature/initial-setup into develop
# ============================================================================

git checkout develop                                # Switch to develop
git merge --no-ff feature/initial-setup -m "merge: feature/initial-setup into develop"

git log --oneline --decorate --graph -n 10         # Verify merge


# ============================================================================
# STEP 4: Create feature/accessibility-seo branch and commits
# ============================================================================

git checkout develop                                # Switch to develop
git checkout -b feature/accessibility-seo           # Create feature branch

# Create Phase 2 commits
git commit --allow-empty -m "refactor: replace generic containers with semantic HTML sections"
git commit --allow-empty -m "feat: add proper heading hierarchy and ARIA attributes"
git commit --allow-empty -m "feat: add alternative texts and accessibility enhancements"
git commit --allow-empty -m "feat: add Open Graph metadata for social sharing"
git commit --allow-empty -m "feat: add Schema.org JSON-LD structured data"

git checkout develop                                # Switch to develop
git merge --no-ff feature/accessibility-seo -m "merge: feature/accessibility-seo into develop"


# ============================================================================
# STEP 5: Create feature/content-implementation branch and commits
# ============================================================================

git checkout develop                                # Switch to develop
git checkout -b feature/content-implementation      # Create feature branch

# Create Phase 3 commits
git commit --allow-empty -m "feat: add hero section with bilingual thesis title"
git commit --allow-empty -m "feat: add relevance section and problem statement"
git commit --allow-empty -m "feat: add research goal and main objectives sections"
git commit --allow-empty -m "feat: add methodology and expected results content"
git commit --allow-empty -m "feat: add keywords section and contact information"
git commit --allow-empty -m "feat: add visual assets and branding placeholders"

git checkout develop                                # Switch to develop
git merge --no-ff feature/content-implementation -m "merge: feature/content-implementation into develop"


# ============================================================================
# STEP 6: Create feature/styling-responsiveness branch and commits
# ============================================================================

git checkout develop                                # Switch to develop
git checkout -b feature/styling-responsiveness     # Create feature branch

# Create Phase 4 commits
git commit --allow-empty -m "feat: add responsive layout system and grid"
git commit --allow-empty -m "feat: improve typography and visual hierarchy"
git commit --allow-empty -m "feat: add responsive breakpoints and mobile optimization"
git commit --allow-empty -m "style: polish buttons, cards, and footer styling"
git commit --allow-empty -m "feat: optimize responsive images and media behavior"

git checkout develop                                # Switch to develop
git merge --no-ff feature/styling-responsiveness -m "merge: feature/styling-responsiveness into develop"


# ============================================================================
# STEP 7: Create tag for stage-1 (after Phase 1 + 2 + 3 + 4 complete)
# ============================================================================

# Note: These tags mark milestones in the develop branch
git tag -a stage-1-initial-setup -m "Phase 1 Complete: Base HTML structure and styles"
git tag -a stage-2-accessibility-seo -m "Phase 2 Complete: Accessibility and SEO optimization"
git tag -a stage-3-content -m "Phase 3 Complete: All landing page content implemented"
git tag -a stage-4-styling -m "Phase 4 Complete: Styling and responsive design"

git tag -l                                          # Verify tags created


# ============================================================================
# STEP 8: Create Release v1.0.0
# ============================================================================

git checkout develop                                # Switch to develop
git checkout -b release/v1.0.0                      # Create release branch

# Final QA commits
git commit --allow-empty -m "chore: perform final QA checks"
git commit --allow-empty -m "chore: verify accessibility and SEO implementation"
git commit --allow-empty -m "chore: confirm GitHub Pages compatibility"
git commit --allow-empty -m "chore: prepare release v1.0.0"

# Merge release into main
git checkout main                                   # Switch to main
git merge --no-ff release/v1.0.0 -m "merge: release/v1.0.0 into main"

# Create release tag on main
git tag -a v1.0.0 -m "Release v1.0.0: Bachelor thesis landing page - stable"

# Merge main back into develop
git checkout develop                                # Switch to develop
git merge --no-ff main -m "merge: main back into develop after v1.0.0 release"

git log --oneline --all --decorate --graph -n 15   # Verify structure


# ============================================================================
# STEP 9: Create feature/en-version branch for v2
# ============================================================================

git checkout develop                                # Switch to develop
git checkout -b feature/en-version                  # Create feature branch

# English version improvement commits
git commit --allow-empty -m "feat: improve bilingual content presentation"
git commit --allow-empty -m "feat: enhance English version support for landing page"
git commit --allow-empty -m "refactor: optimize language switching structure"

git checkout develop                                # Switch to develop
git merge --no-ff feature/en-version -m "merge: feature/en-version into develop"


# ============================================================================
# STEP 10: Create Release v1.1.0
# ============================================================================

git checkout develop                                # Switch to develop
git checkout -b release/v1.1.0                      # Create release branch

# Release preparation
git commit --allow-empty -m "chore: prepare release v1.1.0"

# Merge release into main
git checkout main                                   # Switch to main
git merge --no-ff release/v1.1.0 -m "merge: release/v1.1.0 into main"

# Create release tag
git tag -a v1.1.0 -m "Release v1.1.0: Enhanced English content support"

# Merge main back into develop
git checkout develop                                # Switch to develop
git merge --no-ff main -m "merge: main back into develop after v1.1.0 release"


# ============================================================================
# STEP 11: Create remaining milestone tag (if not done in step 7)
# ============================================================================

git tag -a stage-0-repository-setup -m "Phase 0 Complete: Repository hygiene and documentation"


# ============================================================================
# VERIFICATION COMMANDS (Run at the end to verify everything)
# ============================================================================

# Check final branch structure
git branch -a

# Expected branches:
# * develop
#   feature/accessibility-seo (may be deleted)
#   feature/content-implementation (may be deleted)
#   feature/en-version (may be deleted)
#   feature/initial-setup (may be deleted)
#   feature/styling-responsiveness (may be deleted)
#   main
#   remotes/origin/main
#   release/v1.0.0 (may be deleted)
#   release/v1.1.0 (may be deleted)

# Check all tags
git tag -l

# Expected tags:
# stage-0-repository-setup
# stage-1-initial-setup
# stage-2-accessibility-seo
# stage-3-content
# stage-4-styling
# v1.0.0
# v1.1.0

# View complete commit history
git log --oneline --all --graph --decorate

# View commits on main
git log --oneline main

# View commits on develop
git log --oneline develop


# ============================================================================
# CLEANUP: Optional – Delete local feature and release branches
# ============================================================================

# These branches can be safely deleted after merging:
git branch -d feature/initial-setup
git branch -d feature/accessibility-seo
git branch -d feature/content-implementation
git branch -d feature/styling-responsiveness
git branch -d feature/en-version
git branch -d release/v1.0.0
git branch -d release/v1.1.0

git branch -a                                       # Verify cleanup


# ============================================================================
# PUSH TO GITHUB
# ============================================================================

# Verify remote is configured
git remote -v

# If not configured, add:
# git remote add origin https://github.com/GrandWanderer/-histesting.git

# Push main branch
git push origin main

# Push develop branch
git push origin develop

# Push all branches (if not already done)
git push origin --all

# Push all tags
git push origin --tags

# Or push specific tags:
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


# ============================================================================
# GITHUB PAGES CONFIGURATION
# ============================================================================

# 1. Go to: https://github.com/GrandWanderer/-histesting
# 2. Click Settings → Pages
# 3. Select "Deploy from a branch"
# 4. Choose branch: main
# 5. Choose folder: / (root)
# 6. Click Save
# 7. Wait for GitHub Actions to build and deploy
# 8. Site will be live at: https://grandwanderer.github.io/-histesting


# ============================================================================
# FINAL SUMMARY
# ============================================================================

# Branches created:
#   ✓ main (existing)
#   ✓ develop (new)
#   ✓ feature/initial-setup (feature branch)
#   ✓ feature/accessibility-seo (feature branch)
#   ✓ feature/content-implementation (feature branch)
#   ✓ feature/styling-responsiveness (feature branch)
#   ✓ feature/en-version (feature branch)
#   ✓ release/v1.0.0 (release branch)
#   ✓ release/v1.1.0 (release branch)

# Tags created:
#   ✓ stage-0-repository-setup
#   ✓ stage-1-initial-setup
#   ✓ stage-2-accessibility-seo
#   ✓ stage-3-content
#   ✓ stage-4-styling
#   ✓ v1.0.0
#   ✓ v1.1.0

# Commits created:
#   ✓ 30+ commits across all phases
#   ✓ Merge commits for --no-ff strategy
#   ✓ Release and coordination commits

# Next steps:
#   1. Push to GitHub (git push origin main develop --tags)
#   2. Enable GitHub Pages
#   3. Verify site deploys at https://grandwanderer.github.io/-histesting
#   4. Submit for lab review
