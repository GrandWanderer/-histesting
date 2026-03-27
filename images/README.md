# Image Assets for Bachelor Thesis Landing Page

This directory should contain the following image files:

## Required Images

### University Branding
- **university-logo.png** (32x32px minimum)
  - PNG format
  - Sumy State University logo
  - Used in navbar and footer
  - Placeholder: Currently referenced but not committed

### Hero Image
- **dental-clinic-hero.webp** (1200x800px recommended)
  - WebP format (modern, optimized)
  - Related to dental clinic management/healthcare automation
  - Used in hero section
  - Fallback: Could use JPG if WebP unavailable

## Favicon Files
Multiple sizes for different platforms:
- **favicon-16x16.png** (16x16px)
- **favicon-32x32.png** (32x32px)
- **apple-touch-icon.png** (180x180px)
- **android-chrome-192x192.png** (192x192px)

## Image Specifications

### Format Recommendations
- Use WebP for modern browsers (better compression)
- Fallback to JPG/PNG for compatibility
- Optimize all images for web (< 300KB total for all images)

### Alt Text
All images have alt text specified in HTML for accessibility.

### Responsive Handling
Images use:
- `srcset` attributes for responsive sizing
- `loading="lazy"` for below-fold images
- CSS max-width: 100% for responsive scaling

## Adding Images

To add images to this project:

1. Create PNG or WebP files with proper dimensions
2. Place in `images/` directory
3. Name exactly as specified above
4. Update `index.html` `src` attributes if paths differ
5. Test in multiple browsers

## Placeholder Alternatives

If real images are not available, use:
- Placeholder services: placeholder.com, via.placeholder.com
- Or system colors/gradients in CSS

Example placeholder reference:
```html
<img src="https://via.placeholder.com/1200x800" alt="Placeholder">
```

## Images Already Referenced in Code

The following images are already referenced in `index.html`:
- images/university-logo.png
- images/dental-clinic-hero.webp
- images/favicon-16x16.png
- images/favicon-32x32.png
- images/apple-touch-icon.png
- images/android-chrome-192x192.png

## Creating Placeholder Images (Quick Method)

If no images available, create temporary placeholders:

### Using Python PIL:
```python
from PIL import Image, ImageDraw, ImageFont

# Create placeholder
img = Image.new('RGB', (1200, 800), color=(52, 152, 219))
draw = ImageDraw.Draw(img)
draw.text((600, 400), "Dental Clinic Hero Image", fill=(255, 255, 255), anchor="mm")
img.save('images/dental-clinic-hero.webp', 'WEBP')
```

### Using ImageMagick:
```bash
# Hero image
convert -size 1200x800 xc:"#3498db" \
    -pointsize 48 -fill white -gravity center \
    -annotate 0 "Dental Clinic Management System" \
    images/dental-clinic-hero.webp

# University logo placeholder
convert -size 32x32 xc:"#2c3e50" \
    -pointsize 10 -fill white -gravity center \
    -annotate 0 "SSU" \
    images/university-logo.png
```

### Using Online Services:
- https://via.placeholder.com/1200x800?text=Dental+Clinic+System
- Then save locally

## Git Handling

Images are typically NOT committed to git repository because:
- Large file sizes
- Binary data creates bloat
- GitHub has size limits

### Option 1: Git LFS (Large File Storage)
```bash
git lfs install
git lfs track "images/*.webp" "images/*.png"
git add .gitattributes
git commit -m "chore: add git lfs tracking for large image files"
```

### Option 2: Exclude from git
Add to .gitignore:
```
# Already in .gitignore:
# images/ (if committing only non-binary files)
```

### Option 3: Use CDN or Asset Server
Reference images from external CDN instead of repository.

---

**Note:** For academic submission, discuss image inclusion strategy with your instructor.
Last Updated: March 2026
