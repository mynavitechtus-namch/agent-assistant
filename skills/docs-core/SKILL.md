---
name: docs-core
description: "Generate or update the 5 core project knowledge documents (overview, architecture, domain, source-base, standards) in ./documents/. Performs autonomous codebase scanning, gap analysis, and produces enterprise-grade documentation for rapid onboarding. Use when user says 'generate docs', 'update docs', 'create project documentation', 'docs-core', '/docs-core', 'onboarding docs', or wants to create/refresh the knowledge base."
---

# Docs-Core — Core Project Documentation Generator

> **Mission**: Autonomously scan a codebase and produce (or update) **ALL 5** core knowledge documents at the highest quality standard. Every document must enable a new team member to fully understand the project's architecture and business domain in minimal time.

---

## Overview

Intelligent documentation engine. It handles two modes:

- **CREATE** — Generate documents from scratch when `./documents/` is empty or files are missing.
- **UPDATE** — Incrementally enrich existing documents by appending new content and correcting stale sections, **without discarding valuable existing context**.

All output files are written in **English only** regardless of the user's language.

**Critical Principle**: The helper script is only a bootstrap accelerator. Final documentation quality must come from **hybrid reconnaissance**: script output + targeted code search + direct file reading + cross-check against existing documents.

---

## When to Use

- User asks to generate, create, or refresh project documentation.
- User mentions "docs-core", "/docs-core", "knowledge base", or "onboarding docs".
- User wants to onboard new team members with comprehensive project docs.
- User wants to synchronize documentation with recent code changes.
- After major refactoring, migration, or feature additions.

---

## Deliverables

| # | File | Purpose |
|---|------|---------|
| 1 | `./documents/knowledge-overview.md` | Project identity, goals, tech stack, getting started |
| 2 | `./documents/knowledge-architecture.md` | System design, components, data flow, design patterns |
| 3 | `./documents/knowledge-domain.md` | Data models, schemas, API contracts, business rules |
| 4 | `./documents/knowledge-source-base.md` | Directory tree, file purposes, entry points, modules |
| 5 | `./documents/knowledge-standards.md` | Code style, naming, commit format, PR guidelines |

**Failure condition**: If fewer than 5 files are produced, the execution is **INCOMPLETE**.

---

## Step-by-Step Workflow

### Step 0: Pre-Flight Validation

```
BEFORE any work:
1. Confirm ./documents/ directory exists (create if missing)
2. Load templates directly from `skills/docs-core/references/` (read-only, in place)
3. Do not create or persist template copies under `./documents/templates/`
4. Check which of the 5 files already exist
5. Determine execution mode per file:
   - File missing → CREATE mode
   - File exists  → UPDATE mode
6. Log the execution plan
```

**Output**:
```markdown
📋 Docs-Core Execution Plan
| File | Status | Mode |
|------|--------|------|
| knowledge-overview.md | ✅ Exists / ❌ Missing | UPDATE / CREATE |
| knowledge-architecture.md | ✅ Exists / ❌ Missing | UPDATE / CREATE |
| knowledge-domain.md | ✅ Exists / ❌ Missing | UPDATE / CREATE |
| knowledge-source-base.md | ✅ Exists / ❌ Missing | UPDATE / CREATE |
| knowledge-standards.md | ✅ Exists / ❌ Missing | UPDATE / CREATE |

📚 Template Source
- Source: `skills/docs-core/references/*.md`
- Mode: read-only, no copy
```

---

### Step 1: Codebase Reconnaissance

Perform a comprehensive scan of the entire project to gather raw intelligence.

**Execution model (MANDATORY): HYBRID RECON**
1. Run script bootstrap: `scripts/scan-project.sh`.
2. Run targeted search passes for architecture/domain/standards signals.
3. Read representative high-value files directly (not only summaries).
4. Build an evidence ledger mapping each major claim to source files.

If any of these 4 parts is skipped, documentation is considered incomplete.

**1.1 — Structure Scan**:
- List all top-level directories and files.
- Recursively map the directory tree (depth 3–4 levels).
- Identify entry points: `main.*`, `index.*`, `app.*`, `server.*`, `package.json`, `Makefile`, `Dockerfile`, etc.

Minimum direct-read set (must read content, not only file names):
- Repository entry docs: `README*`, `CHANGELOG*`, `CONTRIBUTING*` when present.
- Build/runtime manifests: package/lock files and framework configs.
- At least one entry-point file per runtime surface (web, API, worker, CLI).

**1.2 — Tech Stack Detection**:
- Parse `package.json`, `requirements.txt`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `pom.xml`, `build.gradle`, `Gemfile`, `composer.json`, `.csproj`, or equivalent.
- Detect frameworks from imports/config: React, Next.js, Express, Django, FastAPI, Spring Boot, Rails, Laravel, etc.
- Identify databases from connection strings, ORM config, or migration files.
- Detect CI/CD from `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`, etc.
- Detect containerization: `Dockerfile`, `docker-compose.yml`.

**1.3 — Pattern Discovery**:
- Scan for architectural patterns: MVC, MVVM, Clean Architecture, Hexagonal, Microservices, Monolith.
- Identify design patterns from code: Repository, Factory, Observer, Middleware, DI, etc.
- Note naming conventions observed in files, variables, functions, and classes.
- Detect test frameworks and test file patterns.
- Find configuration patterns: env files, config modules, feature flags.

Required targeted search passes (minimum):
- Architecture keywords: `controller|service|repository|use-case|domain|module|adapter|middleware|handler`.
- API surface: `router|route|endpoint|graphql|openapi|swagger|trpc`.
- Data model surface: `model|schema|entity|migration|prisma|typeorm|sequelize|mongoose|sql`.
- Standards surface: `eslint|prettier|editorconfig|commitlint|husky|lint-staged|test`.
- Business language surface: domain nouns from README/docs/comments.

**1.4 — Domain Intelligence**:
- Locate data models: ORM models, schemas, type definitions, interfaces.
- Find API definitions: route files, controllers, GraphQL schemas, OpenAPI specs.
- Identify business logic layers: services, use cases, domain modules.
- Map relationships between entities from foreign keys, references, imports.

**1.5 — Context-Window Optimization**:
> To avoid context overflow on large codebases, use these strategies:
> - Run the `scripts/scan-project.sh` helper script if available to get a compact summary.
> - Read files selectively: config files first, then entry points, then key modules.
> - Use `grep` to search for patterns rather than reading entire files.
> - Prioritize: package manifests → entry points → route/controller files → model files → test files.
> - For monorepos, scan each package's manifest separately.

**Anti-shallow guardrails**:
- Never generate sections using only script output.
- For each core document, use at least 3 direct evidence sources.
- If evidence is weak, write `Not applicable to this project` instead of guessing.

**Evidence Ledger (MANDATORY)**
- Produce a compact mapping before writing docs:

```markdown
## Evidence Ledger
| Claim Area | Evidence Files | Confidence |
|-----------|----------------|------------|
| Architecture | {paths} | High/Medium/Low |
| Domain Model | {paths} | High/Medium/Low |
| Standards | {paths} | High/Medium/Low |
| Source Structure | {paths} | High/Medium/Low |
```

---

### Step 2: Gap Analysis (UPDATE mode only)

When existing documents are found, perform a diff-aware analysis:

```
FOR each existing document:
  1. READ the current content completely.
  2. COMPARE against reconnaissance findings.
  3. IDENTIFY:
     a. Stale sections — info no longer matching codebase
     b. Missing sections — new components/features not documented
     c. Accurate sections — still correct, DO NOT TOUCH
  4. PLAN targeted edits:
     - APPEND new sections for new discoveries
     - REVISE stale paragraphs with corrected info
     - PRESERVE all existing context that remains valid
```

**UPDATE Rules**:
- **NEVER** delete existing sections that are still accurate.
- **AVOID** rewriting from scratch in UPDATE mode.
- **ALLOW** controlled rewrite only when file is structurally broken or over 70% stale.
- For controlled rewrite, preserve still-valid legacy context under `## Legacy Notes (Preserved Context)`.
- **ALWAYS** add a changelog entry at the bottom: `> Last updated: {date} — {summary of changes}`.
- **PREFER** appending new subsections over modifying existing ones.
- Mark newly added sections with: `<!-- Added: {date} -->` HTML comment.

---

### Step 3: Content Generation (Thinking Protocol)

For each of the 5 documents, apply this thinking protocol **before** writing:

```
THINK:
  1. WHO is the reader? → New developer, BA/PM, or AI agent.
  2. WHAT must they understand from this file alone?
  3. WHAT data from reconnaissance supports each section?
  4. Is every claim backed by actual code evidence?
  5. Is any section speculative? → Remove or mark as assumption.
  6. Would a new team member find this sufficient for their first day?
  7. Is the language professional, direct, and jargon-appropriate?

VERIFY before writing:
  □ Every technical claim references actual files or patterns found
  □ No placeholder text ("TODO", "TBD", "fill in later")
  □ Table of Contents matches actual headings
  □ Mermaid diagrams (if used) are syntactically valid
  □ All file paths referenced actually exist in the project
```

**Generation order** (each file builds on the previous):
1. `knowledge-source-base.md` — Foundation: where things are
2. `knowledge-overview.md` — Identity: what and why
3. `knowledge-architecture.md` — Design: how things connect
4. `knowledge-domain.md` — Data: what data flows through
5. `knowledge-standards.md` — Rules: how to contribute correctly

**Onboarding-first requirements**:
- Every generated file must include one subsection named `Onboarding Notes`.
- `knowledge-overview.md` must include `First 60 Minutes` checklist.
- `knowledge-source-base.md` must include `Read Order for New Members`.

---

### Step 4: Write Documents

For each document, follow the corresponding template structure from `references/`.

**Writing rules**:
- **Language**: English only. No exceptions.
- **Tone**: Professional, direct, accessible to both business and technical readers.
- **Format**: Standard Markdown with GFM extensions (tables, task lists, fenced code blocks).
- **TOC**: Every file MUST begin with a Table of Contents after the title.
- **Diagrams**: Use Mermaid.js for flowcharts, entity relationships, and architecture diagrams where they add clarity by visualizing relationships that text alone cannot convey.
- **Tables**: Use tables for structured data (APIs, config vars, file listings).
- **Code blocks**: Use fenced code blocks with language identifiers.
- **Headings**: H1 for title, H2 for major sections, H3 for subsections, H4 for details.
- **Metadata header**: Every file starts with:

```markdown
# {Project Name} — {Document Title}

> **Purpose**: {one-line purpose statement}
> **Last Updated**: {YYYY-MM-DD}
> **Generated By**: docs-core skill

---

## Table of Contents

- [1. Section Name](#1-section-name)
  - [1.1 Subsection](#11-subsection)
...
```

- **Evidence section**: Every file must include `## Evidence Sources` listing concrete files used.
- **Known gaps section**: Every file must include `## Known Gaps and Open Questions`.

---

### Step 5: Verification Checklist

After generating all 5 files, verify:

```
VERIFICATION MATRIX:
| Check | knowledge-overview | knowledge-architecture | knowledge-domain | knowledge-source-base | knowledge-standards |
|-------|-------------------|----------------------|-----------------|---------------------|-------------------|
| File exists | □ | □ | □ | □ | □ |
| TOC present | □ | □ | □ | □ | □ |
| No TODO/TBD | □ | □ | □ | □ | □ |
| English only | □ | □ | □ | □ | □ |
| Minimum sections | □ | □ | □ | □ | □ |
| File paths valid | □ | □ | □ | □ | □ |
| Diagrams render | □ | □ | □ | □ | □ |
| Professional tone | □ | □ | □ | □ | □ |
| Evidence Sources present | □ | □ | □ | □ | □ |
| Known gaps section present | □ | □ | □ | □ | □ |
```

**Minimum section requirements per file**:
- `knowledge-overview.md`: ≥ 6 sections (Identity, Purpose, Tech Stack, Features, Quick Start, Configuration)
- `knowledge-architecture.md`: ≥ 5 sections (Overview, Components, Data Flow, Patterns, Dependencies)
- `knowledge-domain.md`: ≥ 5 sections (Entities, Relationships, Schema, API Contracts, Business Rules)
- `knowledge-source-base.md`: ≥ 4 sections (Root Structure, Directory Breakdown, Entry Points, Key Files)
- `knowledge-standards.md`: ≥ 5 sections (Naming, Style, Commit Format, PR Guidelines, Testing)

**Coverage quality gates**:
- Every major section must be backed by at least one explicit evidence file.
- No document may contain unresolved placeholders.
- If confidence is low for a section, mark confidence and list follow-up actions.

---

### Step 6: Completion Report

Present the final status to the user:

```markdown
## ✅ Docs-Core Complete

### 📦 Deliverables
| # | File | Mode | Status |
|---|------|------|--------|
| 1 | ./documents/knowledge-overview.md | CREATE/UPDATE | ✅ |
| 2 | ./documents/knowledge-architecture.md | CREATE/UPDATE | ✅ |
| 3 | ./documents/knowledge-domain.md | CREATE/UPDATE | ✅ |
| 4 | ./documents/knowledge-source-base.md | CREATE/UPDATE | ✅ |
| 5 | ./documents/knowledge-standards.md | CREATE/UPDATE | ✅ |

### 📊 Coverage Summary
- Tech stack documented: {list}
- Architecture patterns identified: {list}
- Domain entities mapped: {count}
- Source directories documented: {count}
- Standards defined: {count}

### 📝 Next Steps
- `/docs:business` — Generate business documentation
- Review and customize generated docs for project-specific nuances
```

---

## Document Templates

Detailed templates for each document are stored in `references/`. Load the relevant template when generating each file:

| Template File | Produces |
|---------------|----------|
| `references/template-overview.md` | knowledge-overview.md |
| `references/template-architecture.md` | knowledge-architecture.md |
| `references/template-domain.md` | knowledge-domain.md |
| `references/template-source-base.md` | knowledge-source-base.md |
| `references/template-standards.md` | knowledge-standards.md |
| `references/deep-recon-checklist.md` | Mandatory deep reconnaissance checklist |

**Usage**: Read the template → Fill sections with reconnaissance data → Write to `./documents/`.

---

## Helper Scripts

### `scripts/scan-project.sh`

A lightweight project scanner that produces a compact summary for context-window efficiency. Outputs: directory tree, tech stack hints, file counts, and line counts.

**When to use**: On large codebases (>500 files) to avoid context overflow. Run before Step 1 to get a structured overview.

```bash
# Usage
bash skills/docs-core/scripts/scan-project.sh [project-root]
```

---

## Quality Standards

### Acceptance Criteria

| Criterion | Requirement |
|-----------|-------------|
| **Completeness** | All 5 files produced with all required sections |
| **Accuracy** | Every technical claim backed by actual code evidence |
| **Freshness** | Content reflects current codebase state, not historical |
| **Readability** | Understandable by both BA/PM and junior developers |
| **Format** | Valid Markdown, valid Mermaid, proper TOC, no broken links |
| **Language** | English only in all document files |
| **No Placeholders** | Zero TODO, TBD, or "fill in later" markers |
| **Professional Tone** | Direct, clear, no filler, no marketing-speak |
| **Update Safety** | UPDATE mode preserves existing valuable context |

### Quality Bar

> **This skill does NOT accept "good enough" output.**
> Every section, sentence, and character must be deliberate. Before writing each section, apply the Thinking Protocol (Step 3) to ensure the content is the most accurate, most useful, and most complete representation possible. If a section cannot be filled with verified data, state: "Not applicable to this project" rather than guessing.

---

## Examples

### Example 1: New Project (CREATE mode)

```
User: Generate documentation for this project

Docs-Core Process:
1. Pre-Flight: ./documents/ exists but all 5 files missing → CREATE mode
2. Reconnaissance: Scan finds Next.js + Prisma + PostgreSQL monorepo
3. Generation order: source-base → overview → architecture → domain → standards
4. Write all 5 files with full templates
5. Verify: All checks pass
6. Report: 5/5 files created
```

### Example 2: Existing Project (UPDATE mode)

```
User: Update the docs, we added a new module

Docs-Core Process:
1. Pre-Flight: All 5 files exist → UPDATE mode
2. Reconnaissance: Scan finds new `payments/` module with Stripe integration
3. Gap Analysis: knowledge-architecture.md missing payments component,
   knowledge-domain.md missing PaymentIntent entity
4. Targeted edits: Append payments section to architecture, add entity to domain
5. Verify: All checks pass, existing content preserved
6. Report: 2/5 files updated, 3/5 unchanged
```

### Example 3: Partial Documentation (MIXED mode)

```
User: Create docs for this repo

Docs-Core Process:
1. Pre-Flight: 2 files exist (overview, standards), 3 missing → MIXED mode
2. Scan codebase, read existing 2 files
3. CREATE 3 missing files, UPDATE 2 existing files if stale
4. Verify all 5 files complete
5. Report: 3 created, 2 updated
```
