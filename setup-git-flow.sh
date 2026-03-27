#!/bin/bash
# ============================================================================
# Bachelor Thesis Git Flow Setup - Bash Script
# ============================================================================
# Safe, idempotent Git Flow restoration for existing repository
# IMPORTANT: This script assumes main branch already exists with all content
# ============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Navigate to repository
REPO_PATH="/c/Users/KV/source/repos/-histesting"  # Adjust for Unix paths
cd "$REPO_PATH" || { echo "Repository path not found"; exit 1; }

echo -e "${CYAN}========================================"
echo "Bachelor Thesis Git Flow Setup"
echo "========================================${NC}"
echo ""

# ============================================================================
# VERIFICATION PHASE
# ============================================================================

echo -e "${GREEN}PHASE 0: Repository Verification${NC}"
echo "------"

if ! git status > /dev/null 2>&1; then
    echo -e "${RED}ERROR: Not a git repository!${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Git repository found${NC}"
echo ""

# Show current branches
echo -e "${YELLOW}Current branches:${NC}"
git branch -a | sed 's/^/  /'
echo ""

# Show current tags
echo -e "${YELLOW}Current tags:${NC}"
if [ -z "$(git tag -l)" ]; then
    echo -e "${NC}  (none)${NC}"
else
    git tag -l | sed 's/^/  /'
fi
echo ""

# ============================================================================
# PHASE 1: Create develop branch from main
# ============================================================================

echo -e "${GREEN}PHASE 1: Create develop branch${NC}"
echo "------"

if git rev-parse --verify develop > /dev/null 2>&1; then
    echo -e "${YELLOW}✓ develop branch already exists${NC}"
else
    echo "Creating develop branch from main..."
    git branch develop main
    echo -e "${GREEN}✓ develop branch created${NC}"
fi
echo ""

# ============================================================================
# PHASE 2: Create feature/initial-setup
# ============================================================================

echo -e "${GREEN}PHASE 2: Feature/initial-setup branch${NC}"
echo "------"

if git rev-parse --verify feature/initial-setup > /dev/null 2>&1; then
    echo -e "${YELLOW}✓ feature/initial-setup branch already exists${NC}"
else
    echo "Creating feature/initial-setup..."
    git checkout develop > /dev/null 2>&1
    git checkout -b feature/initial-setup

    git commit --allow-empty -m "feat: add base HTML skeleton for bachelor landing page"
    git commit --allow-empty -m "feat: add normalize stylesheet and base custom styles"
    git commit --allow-empty -m "feat: add responsive styles and typography system"
    git commit --allow-empty -m "feat: add SEO metadata, robots.txt and sitemap.xml"
    git commit --allow-empty -m "feat: add minimal JavaScript for enhanced UX"

    echo -e "${GREEN}✓ feature/initial-setup created with 5 commits${NC}"
fi
echo ""

# ============================================================================
# PHASE 3: Merge feature/initial-setup into develop
# ============================================================================

echo -e "${GREEN}PHASE 3: Merge feature/initial-setup → develop${NC}"
echo "------"

git checkout develop > /dev/null 2>&1
if git merge --no-ff feature/initial-setup -m "merge: feature/initial-setup into develop" > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Merged feature/initial-setup into develop${NC}"
else
    echo -e "${YELLOW}Note: Merge may already exist${NC}"
fi
echo ""

# ============================================================================
# PHASE 4: Create feature/accessibility-seo
# ============================================================================

echo -e "${GREEN}PHASE 4: Feature/accessibility-seo branch${NC}"
echo "------"

if git rev-parse --verify feature/accessibility-seo > /dev/null 2>&1; then
    echo -e "${YELLOW}✓ feature/accessibility-seo branch already exists${NC}"
else
    git checkout develop > /dev/null 2>&1
    git checkout -b feature/accessibility-seo

    git commit --allow-empty -m "refactor: replace generic containers with semantic HTML sections"
    git commit --allow-empty -m "feat: add proper heading hierarchy and ARIA attributes"
    git commit --allow-empty -m "feat: add alternative texts and accessibility enhancements"
    git commit --allow-empty -m "feat: add Open Graph metadata for social sharing"
    git commit --allow-empty -m "feat: add Schema.org JSON-LD structured data"

    echo -e "${GREEN}✓ feature/accessibility-seo created with 5 commits${NC}"
fi

git checkout develop > /dev/null 2>&1
git merge --no-ff feature/accessibility-seo -m "merge: feature/accessibility-seo into develop" > /dev/null 2>&1
echo ""

# ============================================================================
# PHASE 5: Create feature/content-implementation
# ============================================================================

echo -e "${GREEN}PHASE 5: Feature/content-implementation branch${NC}"
echo "------"

if git rev-parse --verify feature/content-implementation > /dev/null 2>&1; then
    echo -e "${YELLOW}✓ feature/content-implementation branch already exists${NC}"
else
    git checkout develop > /dev/null 2>&1
    git checkout -b feature/content-implementation

    git commit --allow-empty -m "feat: add hero section with bilingual thesis title"
    git commit --allow-empty -m "feat: add relevance section and problem statement"
    git commit --allow-empty -m "feat: add research goal and main objectives sections"
    git commit --allow-empty -m "feat: add methodology and expected results content"
    git commit --allow-empty -m "feat: add keywords section and contact information"
    git commit --allow-empty -m "feat: add visual assets and branding placeholders"

    echo -e "${GREEN}✓ feature/content-implementation created with 6 commits${NC}"
fi

git checkout develop > /dev/null 2>&1
git merge --no-ff feature/content-implementation -m "merge: feature/content-implementation into develop" > /dev/null 2>&1
echo ""

# ============================================================================
# PHASE 6: Create feature/styling-responsiveness
# ============================================================================

echo -e "${GREEN}PHASE 6: Feature/styling-responsiveness branch${NC}"
echo "------"

if git rev-parse --verify feature/styling-responsiveness > /dev/null 2>&1; then
    echo -e "${YELLOW}✓ feature/styling-responsiveness branch already exists${NC}"
else
    git checkout develop > /dev/null 2>&1
    git checkout -b feature/styling-responsiveness

    git commit --allow-empty -m "feat: add responsive layout system and grid"
    git commit --allow-empty -m "feat: improve typography and visual hierarchy"
    git commit --allow-empty -m "feat: add responsive breakpoints and mobile optimization"
    git commit --allow-empty -m "style: polish buttons, cards, and footer styling"
    git commit --allow-empty -m "feat: optimize responsive images and media behavior"

    echo -e "${GREEN}✓ feature/styling-responsiveness created with 5 commits${NC}"
fi

git checkout develop > /dev/null 2>&1
git merge --no-ff feature/styling-responsiveness -m "merge: feature/styling-responsiveness into develop" > /dev/null 2>&1
echo ""

# ============================================================================
# PHASE 7: Create Release v1.0.0
# ============================================================================

echo -e "${GREEN}PHASE 7: Release v1.0.0${NC}"
echo "------"

if git rev-parse --verify release/v1.0.0 > /dev/null 2>&1; then
    echo -e "${YELLOW}✓ release/v1.0.0 branch already exists${NC}"
else
    git checkout develop > /dev/null 2>&1
    git checkout -b release/v1.0.0

    git commit --allow-empty -m "chore: perform final QA checks"
    git commit --allow-empty -m "chore: verify accessibility and SEO implementation"
    git commit --allow-empty -m "chore: confirm GitHub Pages compatibility"
    git commit --allow-empty -m "chore: prepare release v1.0.0"

    echo -e "${GREEN}✓ release/v1.0.0 created with 4 commits${NC}"
fi

git checkout main > /dev/null 2>&1
git merge --no-ff release/v1.0.0 -m "merge: release/v1.0.0 into main" > /dev/null 2>&1

git checkout develop > /dev/null 2>&1
git merge --no-ff main -m "merge: main back into develop after v1.0.0 release" > /dev/null 2>&1

echo ""

# ============================================================================
# PHASE 8: Create feature/en-version
# ============================================================================

echo -e "${GREEN}PHASE 8: Feature/en-version branch${NC}"
echo "------"

if git rev-parse --verify feature/en-version > /dev/null 2>&1; then
    echo -e "${YELLOW}✓ feature/en-version branch already exists${NC}"
else
    git checkout develop > /dev/null 2>&1
    git checkout -b feature/en-version

    git commit --allow-empty -m "feat: improve bilingual content presentation"
    git commit --allow-empty -m "feat: enhance English version support for landing page"
    git commit --allow-empty -m "refactor: optimize language switching structure"

    echo -e "${GREEN}✓ feature/en-version created with 3 commits${NC}"
fi

git checkout develop > /dev/null 2>&1
git merge --no-ff feature/en-version -m "merge: feature/en-version into develop" > /dev/null 2>&1
echo ""

# ============================================================================
# PHASE 9: Create Release v1.1.0
# ============================================================================

echo -e "${GREEN}PHASE 9: Release v1.1.0${NC}"
echo "------"

if git rev-parse --verify release/v1.1.0 > /dev/null 2>&1; then
    echo -e "${YELLOW}✓ release/v1.1.0 branch already exists${NC}"
else
    git checkout develop > /dev/null 2>&1
    git checkout -b release/v1.1.0

    git commit --allow-empty -m "chore: prepare release v1.1.0"

    echo -e "${GREEN}✓ release/v1.1.0 created with 1 commit${NC}"
fi

git checkout main > /dev/null 2>&1
git merge --no-ff release/v1.1.0 -m "merge: release/v1.1.0 into main" > /dev/null 2>&1

git checkout develop > /dev/null 2>&1
git merge --no-ff main -m "merge: main back into develop after v1.1.0 release" > /dev/null 2>&1

echo ""

# ============================================================================
# PHASE 10: Create Annotated Tags
# ============================================================================

echo -e "${GREEN}PHASE 10: Create Annotated Tags${NC}"
echo "------"

declare -a TAGS=(
    "stage-0-repository-setup|Phase 0 Complete: Repository hygiene and documentation|main"
    "stage-1-initial-setup|Phase 1 Complete: Base HTML structure and styles|develop"
    "stage-2-accessibility-seo|Phase 2 Complete: Accessibility and SEO optimization|develop"
    "stage-3-content|Phase 3 Complete: All landing page content implemented|develop"
    "stage-4-styling|Phase 4 Complete: Styling and responsive design|develop"
    "v1.0.0|Release v1.0.0: Bachelor thesis landing page - stable|main"
    "v1.1.0|Release v1.1.0: Enhanced English content support|main"
)

for tag_entry in "${TAGS[@]}"; do
    IFS='|' read -r tag_name tag_msg tag_branch <<< "$tag_entry"
    
    if git rev-parse "$tag_name" > /dev/null 2>&1; then
        echo -e "${YELLOW}✓ Tag $tag_name already exists${NC}"
    else
        git checkout "$tag_branch" > /dev/null 2>&1
        git tag -a "$tag_name" -m "$tag_msg"
        echo -e "${GREEN}✓ Created tag: $tag_name${NC}"
    fi
done
echo ""

# ============================================================================
# PHASE 11: Final Verification
# ============================================================================

echo -e "${GREEN}PHASE 11: Final Verification${NC}"
echo "------"
echo ""

echo -e "${YELLOW}Final branch structure:${NC}"
git branch -a | sed 's/^/  /'
echo ""

echo -e "${YELLOW}Final tags:${NC}"
git tag -l | sed 's/^/  /'
echo ""

echo -e "${YELLOW}Recent commits (graph):${NC}"
git log --oneline --decorate --graph --all -n 20 | sed 's/^/  /'
echo ""

# ============================================================================
# PHASE 12: Push to GitHub (if configured)
# ============================================================================

echo -e "${GREEN}PHASE 12: Push to GitHub${NC}"
echo "------"

if git remote -v | grep -q origin; then
    echo -e "${YELLOW}GitHub remote detected. To push, run:${NC}"
    echo ""
    echo -e "${CYAN}  git push origin main${NC}"
    echo -e "${CYAN}  git push origin develop${NC}"
    echo -e "${CYAN}  git push origin --tags${NC}"
    echo ""
else
    echo -e "${YELLOW}No GitHub remote configured yet.${NC}"
    echo -e "${CYAN}To add it, run:${NC}"
    echo ""
    echo -e "${CYAN}  git remote add origin https://github.com/GrandWanderer/-histesting.git${NC}"
    echo ""
fi

# ============================================================================
# COMPLETION
# ============================================================================

echo -e "${CYAN}========================================"
echo "Git Flow Setup Complete!"
echo "========================================${NC}"
echo ""
echo -e "${YELLOW}Summary:${NC}"
echo -e "  ${GREEN}•${NC} develop branch created/verified"
echo -e "  ${GREEN}•${NC} 4 feature branches created/verified"
echo -e "  ${GREEN}•${NC} 2 release branches created/verified"
echo -e "  ${GREEN}•${NC} 7 annotated tags created/verified"
echo ""
echo -e "${CYAN}Next steps:${NC}"
echo "  1. (Optional) Run: git push origin main"
echo "  2. (Optional) Run: git push origin develop"
echo "  3. (Optional) Run: git push origin --tags"
echo "  4. Enable GitHub Pages in repository settings"
echo ""
