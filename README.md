# Information System for Dental Clinic Management

## Інформаційна система для управління стоматологічною клінікою

This repository contains a static landing page for a bachelor thesis project. The site presents the concept, goals, and expected outcomes of the thesis project and is intended to be easy to review, host, and maintain.

## Repository Purpose

The repository is used for:

- storing the thesis landing page source files;
- supporting local preview and lightweight collaboration;
- documenting deployment, update, backup, and restore procedures for a static web project;
- providing simple automation scripts for development and operations tasks.

## Project Type

This is a static web project built with:

- HTML5
- CSS3
- JavaScript
- images and other static assets

Applicable infrastructure:

- Web server: yes
- Application server: not required
- Database: not required
- Cache service: not required
- Background workers: not required

## Quick Start For Developers

### Prerequisites

Prepare a clean workstation with:

- `Git`
- a modern web browser such as Chrome, Edge, or Firefox
- a code editor such as Visual Studio Code
- optional: `Python 3` for the local development server
- optional: Node.js with `http-server` installed globally for local preview if Python is unavailable

### Clone The Repository

```bash
git clone https://github.com/GrandWanderer/-histesting.git histesting
cd histesting
```

### Open The Project Locally

You can inspect the project directly by opening `index.html` in a browser, but a local HTTP server is recommended for realistic testing of links and static assets.

Linux or macOS:

```bash
chmod +x docs/scripts/run-dev.sh
./docs/scripts/run-dev.sh
```

Windows:

```bat
docs\scripts\run-dev.bat
```

Default local address:

```text
http://localhost:8000
```

To stop the local server, press `Ctrl+C` in the terminal window where it is running.

## Required Software

Minimum recommended developer tools:

- `Git` for source control
- a browser for visual testing
- an editor for changing HTML, CSS, JS, and Markdown files

Optional but useful:

- `Python 3` for `python -m http.server`
- `Node.js` and `http-server` as an alternative local server

## Common Commands

Start local preview on Linux or macOS:

```bash
./docs/scripts/run-dev.sh
```

Start local preview on Windows:

```bat
docs\scripts\run-dev.bat
```

Check repository status:

```bash
git status
```

Pull the latest changes:

```bash
git pull origin main
```

Generate JavaScript reference documentation:

```bash
npm run docs:generate
```

Run documentation quality checks:

```bash
npm run docs:check
```

Create an archive of the generated documentation:

```bash
npm run docs:archive
```

## Project Structure Overview

```text
.
|-- index.html                 # Main landing page
|-- css/                       # Stylesheets
|-- js/                        # Frontend JavaScript
|-- images/                    # Static images and icons
|-- docs/
|   |-- architecture.md        # Project structure and architecture
|   |-- deployment.md          # Production deployment guide
|   |-- update.md              # Update and rollback process
|   |-- backup.md              # Backup and restore procedures
|   |-- requirements.md        # Existing project requirements
|   |-- report-notes.md        # Existing report notes
|   `-- scripts/               # Local and operational helper scripts
|-- Dockerfile                 # Optional Nginx container image
|-- docker-compose.yml         # Optional local container run file
`-- .github/workflows/         # Optional CI workflow
```

## Local Development Notes

- No build system is required.
- No package installation is required for the site itself, but Node.js dependencies are used for linting, tests, and documentation tooling.
- No database setup is required.
- No application server is required.
- Changes to HTML, CSS, JS, or images can be previewed immediately in the browser after refresh.

## JavaScript Documentation Standard

This project uses `JSDoc` for JavaScript source documentation.

Contributors should document:

- the public `window.LandingPageApp` interface in `js/main.js`;
- any new public functions or reusable browser helpers;
- function parameters, return values, and meaningful side effects;
- non-obvious DOM assumptions, accessibility behavior, and usage notes;
- examples when a function benefits from showing expected usage.

Practical documentation rules for this repository:

- use a JSDoc block directly above each public function;
- include `@param` and `@returns` tags when a function accepts input or returns a value;
- mention side effects when a function binds events, mutates the DOM, or updates CSS classes;
- keep descriptions concise and specific to the landing page behavior;
- update docs and examples whenever landing-page behavior changes.

To regenerate the HTML reference documentation:

```bash
npm run docs:generate
```

Detailed instructions are available in `docs/generate_docs.md`.

## Production Hosting Summary

The primary documented production environment for this repository is:

- Ubuntu Server 22.04 LTS
- Nginx
- Git

Detailed instructions are available in:

- `docs/deployment.md`
- `docs/update.md`
- `docs/backup.md`
- `docs/architecture.md`

## Documentation Map

- `docs/architecture.md` explains the static-site architecture and components.
- `docs/code-documentation.md` explains the frontend behavior, documented public API, and code-level architectural decisions.
- `docs/deployment.md` provides a step-by-step production deployment guide.
- `docs/generate_docs.md` explains how to generate, validate, and archive JSDoc output.
- `docs/update.md` describes how to apply updates and roll back safely.
- `docs/backup.md` describes what to back up and how to restore it.
- `docs/scripts/` contains helper scripts for local preview, deployment, updates, backup, and restore.

## Academic Context

Project title in English:

`Information System for Dental Clinic Management`

Project title in Ukrainian:

`Інформаційна система для управління стоматологічною клінікою`

This repository represents the thesis presentation website, not the full backend implementation of the information system itself.

## License

This project is licensed under the MIT License. See `LICENSE` for details.
