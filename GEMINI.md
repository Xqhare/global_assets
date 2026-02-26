# Global Assets (global_assets)

## Project Overview
This directory contains the shared components (templates, static assets, elements) used across all sites in the **xqhare.net** ecosystem (main, blog, profile).

## Directory Structure
- `elements/`: Source content for shared elements (e.g., `footer.md`).
- `build/`: Generated HTML fragments from source content.
- `build.sh`: Compiles shared elements into HTML fragments using `pandoc`.
- `deploy.sh`: Triggered when global assets change; it calls the `hook.sh` for each sub-project (`main`, `blog`, `profile`) to ensure they are rebuilt with the latest assets.

## Usage
Other sub-projects (like `main`) rebuild `global_assets` during their own build process and append the generated fragments to their final HTML pages.
