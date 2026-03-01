# global_assets

Global Assets for the web service and its sub-services.

This repository holds shared templates, CSS, and images used across all `xqhare.net` subdomains.

## Contents

### Templates (`/templates`)

- `header.html`: The main site navigation header.
- `footer.html`: The shared footer with copyright and contact info.
- `landing.html`: Base template for standard landing pages.
- `blog_post.html`: Specialized template for individual blog entries.
- `blog_snippet.html`: Fragment template used for generating blog post previews.
- `impressum.html`: Legal requirement page template.
- `profile.html`: Template for the profile service.

### Styles (`/css`)

- `main.css`: The central stylesheet for the entire network. 
  - Features responsive design with mobile-first optimizations.
  - Handles image scaling, flexbox layouts, and dark mode aesthetics.

### Media (`/pictures`)

- Shared logos and favicons.

## Integration

All services (`main`, `blog`, `profile`) pull from this repository during their build phase to ensure a consistent look and feel across the network.
