# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.3] - 2026-01-30

### Added

- **Reporter Agent**: New `reporter` agent for documentation and reporting (create/update reports, template-based output).
- **Report Command**: `/report` with variants `auto`, `fast`, `hard`, `focus` — status updates, deep analysis, and focus mode with context optimization.
- **Focus Variant**: For all applicable commands (`cook`, `code`, `fix`, `debug`, `design`, `plan`, `test`) — **Clear context** and **auto-run phases** for guaranteed clean execution without context rot.
- **Matrix-Skills**: Updated `matrix-skills/_index.yaml` with reporter profile and domain mappings.

### Changed

- **Commands**: Router workflows now support **Clear context** and **focus** variant (force clear context, auto run phase) across cook, code, fix, debug, design, plan, test.
- **Documentation**: README, AGENT.md, CLAUDE.md, CURSOR.md, COPILOT.md, GEMINI.md, rules, code-assistants, web data, and documents updated for reporter, `/report`, and focus variants.

## [1.0.2] - 2026-01-30

### Added

- **Web Integration**: Added `web` directory content and resources.
- **Documentation**: Updated `README.md` with comprehensive usage instructions and project details.

## [1.0.1] - 2026-01-29

### Added

- **Matrix Skills Integration**: Implemented a massive library of 2000+ specialized skills (`matrix-skills`) to enhance agent capabilities.
- Improved skill discovery and routing mechanisms.

## [1.0.0] - 2026-01-26

### Added

- **Initial Release**: First stable release of `@namch/agent-assistant`.
- **Core Orchestration**: Framework for managing multi-agent workflows.
- **CLI Tool**: `agent-assistant` CLI for easy installation and management.
- **Multi-Assistant Support**: Compatibility with Cursor, GitHub Copilot, and Claude Code (Antigravity).
