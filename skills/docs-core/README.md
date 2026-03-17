# Docs Core Skill
Build and maintain the five foundational project knowledge documents with evidence-driven precision.

## Why this skill matters
Most repositories have fragmented knowledge: setup steps in one place, architecture in another, and business rules buried in code. Docs Core creates and maintains a single high-quality documentation baseline so onboarding is faster, decisions are safer, and changes are easier to reason about.

## What it generates
Docs Core manages these mandatory outputs in the documents directory:

- documents/knowledge-overview.md
- documents/knowledge-architecture.md
- documents/knowledge-domain.md
- documents/knowledge-source-base.md
- documents/knowledge-standards.md

Mode behavior:

- CREATE: generate missing documents from scratch.
- UPDATE: enrich existing documents with new evidence while preserving valid context.

## Core capabilities
- Runs a structured repository scan using skills/docs-core/scripts/scan-project.sh.
- Produces or updates all five mandatory knowledge documents.
- Uses hybrid reconnaissance: script output plus targeted file reading and pattern search.
- Builds evidence-backed content instead of speculative summaries.
- Preserves still-valid legacy context in UPDATE mode.
- Enforces consistency across architecture, domain, source-base, and standards docs.

## Workflow summary
1. Validate document targets and determine CREATE or UPDATE per file.
2. Scan project structure, stack signals, entry points, and core modules.
3. Build an evidence ledger for architecture, domain, standards, and source map claims.
4. Draft or update each document using the correct template and required sections.
5. Verify quality gates across all five outputs before completion.

## Inputs and evidence sources
- skills/docs-core/SKILL.md
- skills/docs-core/references/template-overview.md
- skills/docs-core/references/template-architecture.md
- skills/docs-core/references/template-domain.md
- skills/docs-core/references/template-source-base.md
- skills/docs-core/references/template-standards.md
- skills/docs-core/references/deep-recon-checklist.md
- skills/docs-core/scripts/scan-project.sh
- Repository manifests, configs, entry points, and representative modules
- Existing files in documents/

## Quality gates / Definition of Done
- All five mandatory documents exist and are internally consistent.
- Each file includes practical, onboarding-ready content rather than generic prose.
- Claims are traceable to repository evidence.
- No placeholder text, unresolved TODOs, or unsupported assumptions.
- Required sections (such as table of contents, evidence sources, known gaps) are present where specified by the workflow.
- UPDATE mode preserves accurate prior context and only revises what changed.

## Typical use cases
- Create onboarding documentation for a newly inherited codebase.
- Refresh stale docs after major refactoring.
- Prepare a repository for team scale-up.
- Align documentation with recent feature delivery.
- Establish a documentation baseline before an audit cycle.
- Reduce tribal knowledge by codifying architecture and standards.

## Quick start usage examples
- "Generate docs-core for this repository"
- "/docs-core"
- "Update project knowledge documents"
- "Refresh onboarding docs from current code"
- "Run docs-core before docs-audit"

## Output quality principles
- Evidence first: every important claim should be backed by source files.
- Onboarding first: docs must help a new teammate become productive quickly.
- Consistency first: architecture, domain, and standards must not conflict.
- Clarity first: concise language, explicit structure, and actionable guidance.
- Maintainability first: documents should be easy to keep current.

## Limitations and non-goals
- Not a substitute for code reviews, tests, or runtime verification.
- Does not invent undocumented business requirements.
- Does not claim certainty where evidence is weak.
- Does not replace product strategy or roadmap documents.
- Does not automatically guarantee long-term freshness without reruns.

## Related resources in this folder
- skills/docs-core/SKILL.md
- skills/docs-core/references/deep-recon-checklist.md
- skills/docs-core/references/template-overview.md
- skills/docs-core/references/template-architecture.md
- skills/docs-core/references/template-domain.md
- skills/docs-core/references/template-source-base.md
- skills/docs-core/references/template-standards.md
- skills/docs-core/scripts/scan-project.sh
