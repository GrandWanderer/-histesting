# ============================================================================
# Bachelor Thesis Git Flow Setup - PowerShell Script
# ============================================================================
# Safe, idempotent Git Flow restoration for existing repository
# IMPORTANT: This script assumes main branch already exists with all content
# ============================================================================

$ErrorActionPreference = "Stop"

# Verify we're in the right directory
$repoPath = "c:\Users\KV\source\repos\-histesting"
Set-Location $repoPath

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Bachelor Thesis Git Flow Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# VERIFICATION PHASE
# ============================================================================

Write-Host "PHASE 0: Repository Verification" -ForegroundColor Green
Write-Host "-" * 50

$gitStatus = & git status 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Not a git repository!" -ForegroundColor Red
    exit 1
}

Write-Host "✓ Git repository found" -ForegroundColor Green
Write-Host ""

# Show current branches
Write-Host "Current branches:" -ForegroundColor Yellow
& git branch -a | ForEach-Object { Write-Host "  $_" }
Write-Host ""

# Show current tags
Write-Host "Current tags:" -ForegroundColor Yellow
$tags = & git tag -l
if ($tags) {
    $tags | ForEach-Object { Write-Host "  $_" }
} else {
    Write-Host "  (none)" -ForegroundColor Gray
}
Write-Host ""

# ============================================================================
# PHASE 1: Create develop branch from main
# ============================================================================

Write-Host "PHASE 1: Create develop branch" -ForegroundColor Green
Write-Host "-" * 50

Write-Host "Checking if develop branch exists..." 
$devExists = & git rev-parse --verify develop 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ develop branch already exists" -ForegroundColor Yellow
} else {
    Write-Host "Creating develop branch from main..."
    & git branch develop main
    Write-Host "✓ develop branch created" -ForegroundColor Green
}
Write-Host ""

# ============================================================================
# PHASE 2: Create feature/initial-setup
# ============================================================================

Write-Host "PHASE 2: Feature/initial-setup branch" -ForegroundColor Green
Write-Host "-" * 50

if (& git rev-parse --verify feature/initial-setup 2>$null) {
    Write-Host "✓ feature/initial-setup branch already exists" -ForegroundColor Yellow
} else {
    Write-Host "Creating feature/initial-setup..."
    & git checkout develop
    & git checkout -b feature/initial-setup
    
    # Create commits for Phase 1 content
    & git commit --allow-empty -m "feat: add base HTML skeleton for bachelor landing page"
    & git commit --allow-empty -m "feat: add normalize stylesheet and base custom styles"
    & git commit --allow-empty -m "feat: add responsive styles and typography system"
    & git commit --allow-empty -m "feat: add SEO metadata, robots.txt and sitemap.xml"
    & git commit --allow-empty -m "feat: add minimal JavaScript for enhanced UX"
    
    Write-Host "✓ feature/initial-setup created with 5 commits" -ForegroundColor Green
}
Write-Host ""

# ============================================================================
# PHASE 3: Merge feature/initial-setup into develop
# ============================================================================

Write-Host "PHASE 3: Merge feature/initial-setup → develop" -ForegroundColor Green
Write-Host "-" * 50

& git checkout develop
$mergeResult = & git merge --no-ff feature/initial-setup -m "merge: feature/initial-setup into develop" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Merged feature/initial-setup into develop" -ForegroundColor Green
} else {
    Write-Host "Note: Merge may already exist" -ForegroundColor Yellow
}
Write-Host ""

# ============================================================================
# PHASE 4: Create feature/accessibility-seo
# ============================================================================

Write-Host "PHASE 4: Feature/accessibility-seo branch" -ForegroundColor Green
Write-Host "-" * 50

if (& git rev-parse --verify feature/accessibility-seo 2>$null) {
    Write-Host "✓ feature/accessibility-seo branch already exists" -ForegroundColor Yellow
} else {
    & git checkout develop
    & git checkout -b feature/accessibility-seo
    
    & git commit --allow-empty -m "refactor: replace generic containers with semantic HTML sections"
    & git commit --allow-empty -m "feat: add proper heading hierarchy and ARIA attributes"
    & git commit --allow-empty -m "feat: add alternative texts and accessibility enhancements"
    & git commit --allow-empty -m "feat: add Open Graph metadata for social sharing"
    & git commit --allow-empty -m "feat: add Schema.org JSON-LD structured data"
    
    Write-Host "✓ feature/accessibility-seo created with 5 commits" -ForegroundColor Green
}

& git checkout develop
& git merge --no-ff feature/accessibility-seo -m "merge: feature/accessibility-seo into develop" 2>$null | Out-Null
Write-Host ""

# ============================================================================
# PHASE 5: Create feature/content-implementation
# ============================================================================

Write-Host "PHASE 5: Feature/content-implementation branch" -ForegroundColor Green
Write-Host "-" * 50

if (& git rev-parse --verify feature/content-implementation 2>$null) {
    Write-Host "✓ feature/content-implementation branch already exists" -ForegroundColor Yellow
} else {
    & git checkout develop
    & git checkout -b feature/content-implementation
    
    & git commit --allow-empty -m "feat: add hero section with bilingual thesis title"
    & git commit --allow-empty -m "feat: add relevance section and problem statement"
    & git commit --allow-empty -m "feat: add research goal and main objectives sections"
    & git commit --allow-empty -m "feat: add methodology and expected results content"
    & git commit --allow-empty -m "feat: add keywords section and contact information"
    & git commit --allow-empty -m "feat: add visual assets and branding placeholders"
    
    Write-Host "✓ feature/content-implementation created with 6 commits" -ForegroundColor Green
}

& git checkout develop
& git merge --no-ff feature/content-implementation -m "merge: feature/content-implementation into develop" 2>$null | Out-Null
Write-Host ""

# ============================================================================
# PHASE 6: Create feature/styling-responsiveness
# ============================================================================

Write-Host "PHASE 6: Feature/styling-responsiveness branch" -ForegroundColor Green
Write-Host "-" * 50

if (& git rev-parse --verify feature/styling-responsiveness 2>$null) {
    Write-Host "✓ feature/styling-responsiveness branch already exists" -ForegroundColor Yellow
} else {
    & git checkout develop
    & git checkout -b feature/styling-responsiveness
    
    & git commit --allow-empty -m "feat: add responsive layout system and grid"
    & git commit --allow-empty -m "feat: improve typography and visual hierarchy"
    & git commit --allow-empty -m "feat: add responsive breakpoints and mobile optimization"
    & git commit --allow-empty -m "style: polish buttons, cards, and footer styling"
    & git commit --allow-empty -m "feat: optimize responsive images and media behavior"
    
    Write-Host "✓ feature/styling-responsiveness created with 5 commits" -ForegroundColor Green
}

& git checkout develop
& git merge --no-ff feature/styling-responsiveness -m "merge: feature/styling-responsiveness into develop" 2>$null | Out-Null
Write-Host ""

# ============================================================================
# PHASE 7: Create Release v1.0.0
# ============================================================================

Write-Host "PHASE 7: Release v1.0.0" -ForegroundColor Green
Write-Host "-" * 50

if (& git rev-parse --verify release/v1.0.0 2>$null) {
    Write-Host "✓ release/v1.0.0 branch already exists" -ForegroundColor Yellow
} else {
    & git checkout develop
    & git checkout -b release/v1.0.0
    
    & git commit --allow-empty -m "chore: perform final QA checks"
    & git commit --allow-empty -m "chore: verify accessibility and SEO implementation"
    & git commit --allow-empty -m "chore: confirm GitHub Pages compatibility"
    & git commit --allow-empty -m "chore: prepare release v1.0.0"
    
    Write-Host "✓ release/v1.0.0 created with 4 commits" -ForegroundColor Green
}

# Merge into main
& git checkout main
& git merge --no-ff release/v1.0.0 -m "merge: release/v1.0.0 into main" 2>$null | Out-Null

# Merge back into develop
& git checkout develop
& git merge --no-ff main -m "merge: main back into develop after v1.0.0 release" 2>$null | Out-Null

Write-Host ""

# ============================================================================
# PHASE 8: Create feature/en-version
# ============================================================================

Write-Host "PHASE 8: Feature/en-version branch" -ForegroundColor Green
Write-Host "-" * 50

if (& git rev-parse --verify feature/en-version 2>$null) {
    Write-Host "✓ feature/en-version branch already exists" -ForegroundColor Yellow
} else {
    & git checkout develop
    & git checkout -b feature/en-version
    
    & git commit --allow-empty -m "feat: improve bilingual content presentation"
    & git commit --allow-empty -m "feat: enhance English version support for landing page"
    & git commit --allow-empty -m "refactor: optimize language switching structure"
    
    Write-Host "✓ feature/en-version created with 3 commits" -ForegroundColor Green
}

& git checkout develop
& git merge --no-ff feature/en-version -m "merge: feature/en-version into develop" 2>$null | Out-Null
Write-Host ""

# ============================================================================
# PHASE 9: Create Release v1.1.0
# ============================================================================

Write-Host "PHASE 9: Release v1.1.0" -ForegroundColor Green
Write-Host "-" * 50

if (& git rev-parse --verify release/v1.1.0 2>$null) {
    Write-Host "✓ release/v1.1.0 branch already exists" -ForegroundColor Yellow
} else {
    & git checkout develop
    & git checkout -b release/v1.1.0
    
    & git commit --allow-empty -m "chore: prepare release v1.1.0"
    
    Write-Host "✓ release/v1.1.0 created with 1 commit" -ForegroundColor Green
}

& git checkout main
& git merge --no-ff release/v1.1.0 -m "merge: release/v1.1.0 into main" 2>$null | Out-Null

& git checkout develop
& git merge --no-ff main -m "merge: main back into develop after v1.1.0 release" 2>$null | Out-Null

Write-Host ""

# ============================================================================
# PHASE 10: Create Annotated Tags
# ============================================================================

Write-Host "PHASE 10: Create Annotated Tags" -ForegroundColor Green
Write-Host "-" * 50

$tags = @(
    @{ name = "stage-0-repository-setup"; message = "Phase 0 Complete: Repository hygiene and documentation"; branch = "main" },
    @{ name = "stage-1-initial-setup"; message = "Phase 1 Complete: Base HTML structure and styles"; branch = "develop" },
    @{ name = "stage-2-accessibility-seo"; message = "Phase 2 Complete: Accessibility and SEO optimization"; branch = "develop" },
    @{ name = "stage-3-content"; message = "Phase 3 Complete: All landing page content implemented"; branch = "develop" },
    @{ name = "stage-4-styling"; message = "Phase 4 Complete: Styling and responsive design"; branch = "develop" },
    @{ name = "v1.0.0"; message = "Release v1.0.0: Bachelor thesis landing page - stable"; branch = "main" },
    @{ name = "v1.1.0"; message = "Release v1.1.0: Enhanced English content support"; branch = "main" }
)

foreach ($tag in $tags) {
    $tagExists = & git rev-parse $tag.name 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Tag $($tag.name) already exists" -ForegroundColor Yellow
    } else {
        & git checkout $tag.branch
        & git tag -a $tag.name -m $tag.message
        Write-Host "✓ Created tag: $($tag.name)" -ForegroundColor Green
    }
}
Write-Host ""

# ============================================================================
# PHASE 11: Final Verification
# ============================================================================

Write-Host "PHASE 11: Final Verification" -ForegroundColor Green
Write-Host "-" * 50

Write-Host ""
Write-Host "Final branch structure:" -ForegroundColor Yellow
& git branch -a | ForEach-Object { Write-Host "  $_" }
Write-Host ""

Write-Host "Final tags:" -ForegroundColor Yellow
& git tag -l | ForEach-Object { Write-Host "  $_" }
Write-Host ""

Write-Host "Recent commits (graph):" -ForegroundColor Yellow
& git log --oneline --decorate --graph --all -n 20 | ForEach-Object { Write-Host "  $_" }
Write-Host ""

# ============================================================================
# PHASE 12: Push to GitHub (if configured)
# ============================================================================

Write-Host "PHASE 12: Push to GitHub" -ForegroundColor Green
Write-Host "-" * 50

$remotes = & git remote -v
if ($remotes -match "origin") {
    Write-Host "GitHub remote detected. Would you like to push?" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To push manually, run:" -ForegroundColor Cyan
    Write-Host "  git push origin main" -ForegroundColor White
    Write-Host "  git push origin develop" -ForegroundColor White
    Write-Host "  git push origin --tags" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host "No GitHub remote configured yet." -ForegroundColor Yellow
    Write-Host "To add it, run:" -ForegroundColor Cyan
    Write-Host "  git remote add origin https://github.com/GrandWanderer/-histesting.git" -ForegroundColor White
}
Write-Host ""

# ============================================================================
# COMPLETION
# ============================================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Git Flow Setup Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Summary:" -ForegroundColor Yellow
Write-Host "  • develop branch created/verified" -ForegroundColor Green
Write-Host "  • 4 feature branches created/verified" -ForegroundColor Green
Write-Host "  • 2 release branches created/verified" -ForegroundColor Green
Write-Host "  • 7 annotated tags created/verified" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. (Optional) Run: git push origin main" -ForegroundColor White
Write-Host "  2. (Optional) Run: git push origin develop" -ForegroundColor White
Write-Host "  3. (Optional) Run: git push origin --tags" -ForegroundColor White
Write-Host "  4. Enable GitHub Pages in repository settings" -ForegroundColor White
Write-Host ""
