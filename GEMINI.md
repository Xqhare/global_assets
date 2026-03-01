# Global Assets (global_assets)

## Project Overview
This directory contains the shared components (templates, static assets, styling) used across all sites in the **xqhare.net** ecosystem (main, blog, profile).

## Directory Structure
- `templates/`: HTML templates used by `pandoc` (e.g., `landing.html`, `blog_post.html`, `blog_snippet.html`, `footer.html`, `header.html`).
- `css/`: Contains `main.css`, the central responsive stylesheet for the network.
- `elements/`: Source content for shared elements (e.g., `footer.md`, `header.md`).
- `build/`: Generated HTML fragments and assets.
- `build.sh`: Compiles shared elements into HTML fragments and prepares the CSS include using `pandoc`. Uses file locking (`flock`) to prevent concurrent rebuilds.
- `deploy.sh`: Triggered when global assets change; it calls the `hook.sh` for each sub-project (`main`, `blog`, `profile`) to ensure they are rebuilt with the latest assets.

## Usage
Other sub-projects rebuild `global_assets` during their own build process and use the generated templates and fragments to construct their final HTML pages.
