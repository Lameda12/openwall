# openwall Brand Identity Design

**Date:** 2026-05-29  
**Version:** 1.0  
**Status:** Active

---

## Overview

openwall is a minimalist, technically-focused macOS wallpaper application. Brand identity reflects open-source ethos, clean aesthetics, and developer accessibility—inspired by Stripe and Vercel.

---

## Color Palette

### Primary Colors
- **Black:** `#000000` — Primary background, text
- **White:** `#FFFFFF` — Secondary background, contrast
- **Green Accent:** `#00FF00` or `#22C55E` (softer) — Interactive elements, highlights

### Usage
- Black + White: primary contrast pair (backgrounds, typography)
- Green: accent for CTAs, active states, brand emphasis
- No gradients; flat, solid colors only

### Dark Mode
Default: light backgrounds with dark text  
Optional: dark mode uses inverted (black bg, white text, green accent unchanged)

---

## Logo

### Mark (Icon)
Three isometric planes representing layered wallpaper:
1. White plane (left) — transparency/accessibility
2. Dark plane (center) — depth
3. Green plane (right) — video/motion

Arrangement: overlapping squares in 3D perspective  
Meaning: wallpaper composition, layering, video playback

### Wordmark
"openwall" in sans-serif (recommend: Inter, Helvetica Neue, or SF Pro)
- "open" in outline/light weight
- "Wall" in green, filled weight
- Creates visual hierarchy; green draws eye to product name part

### Lockup (Combined)
Icon above or to left of wordmark  
Minimum spacing: 1x icon width between mark and text  
Never rotate or distort icon

### Clear Space
Minimum 0.5x icon width around entire lockup (no other elements)

### Files
- Logo SVG (vector master)
- Logo PNG (light bg, 1x + 2x)
- Logo PNG (dark bg, 1x + 2x)
- Icon-only (mark), multiple sizes (16px, 32px, 64px, 128px)

---

## Typography

### Typeface
- **Display:** Inter Bold or Helvetica Neue Bold (headlines)
- **Body:** Inter Regular or Helvetica Neue Regular (copy)
- **Code:** SF Mono or Courier New (technical content)

### Scale
- H1 (Hero): 48px, bold
- H2 (Section): 32px, bold
- H3 (Subsection): 24px, bold
- Body: 16px, regular
- Small: 14px, regular
- Code: 13px, mono

### Line Height
- Headlines: 1.2
- Body: 1.6
- Code: 1.5

---

## Components

### Buttons
- **Primary CTA:** Green background, white text, no border
  - Hover: darker green or slight shadow
  - Padding: 12px 24px
  - Border-radius: 4px (slight)
- **Secondary:** Black border, transparent bg, black text
  - Hover: black bg, white text
  - Padding: 12px 24px
  - Border-radius: 4px

### Cards
- White background, 1px black border
- Padding: 24px
- Border-radius: 4px
- Subtle shadow on hover (optional)

### Links
- Green text, underline on hover
- No color change on visited (open aesthetic)

### Dividers
- 1px solid black or white (depending on bg)
- Full-width or contained

---

## Imagery

### Photography
- Clean, minimal backgrounds (solid colors preferred)
- Product screenshots on black/white backgrounds
- No blur, gradients, or heavy effects

### Icons
- Line-based, minimal (12-24px)
- Black stroke, consistent 1.5px weight
- Examples: play, pause, download, github, menu

### Spacing
- 16px grid baseline
- Margins/padding: 16px, 24px, 32px, 48px
- Never odd spacing values

---

## Voice & Tone

- **Developer-first:** Technical accuracy, no marketing fluff
- **Open:** Transparent about limitations (v0.1.0 = early, no notarization yet)
- **Minimal:** Copy is concise; avoid adjectives
- **Friendly:** Not cold; accessible to non-experts

Example copy:
> "Play MP4 videos behind your desktop icons. <2% CPU. Open source."

Not:
> "Revolutionize your desktop experience with cutting-edge wallpaper technology..."

---

## Applications

### Website (openwall-site repo)
- Hero section: brand + tagline + green CTA
- Feature cards: white bg, green accents
- Code blocks: black bg, mono font
- Buttons: primary green, secondary black

### App (openwall repo)
- Menu bar icon: monochrome (respects system)
- Popover: white bg, black text, green accents
- Window chrome: minimal (no title bar visible)

### Marketing Assets
- Social media: logo + tagline on black or white bg
- GitHub: logo in README
- DMG: brand lockup on installer

---

## Do's & Don'ts

✅ **Do:**
- Use full black/white/green palette
- Keep layouts clean, spacious
- Use system fonts or Inter
- Center text on hero sections
- Show real product screenshots

❌ **Don't:**
- Add shadows, gradients, or blur
- Use decorative elements
- Mix fonts (stick to one typeface)
- Use brand colors as mere decoration
- Create sub-brands or alternative colors

---

## Files & Assets

Location: `/brand/` (shared across repos)
- `logo.svg` — Master vector
- `logo-light.png`, `logo-dark.png` — Branded backgrounds
- `icon-*.png` — Mark only, multiple sizes
- `colors.json` — CSS variables
- `typography.css` — Font imports + scales
- `brand-guidelines.md` — This document

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-05-29 | Initial brand identity |

