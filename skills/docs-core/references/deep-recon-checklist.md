# Deep Recon Checklist for Docs-Core

Use this checklist before generating or updating `./documents/knowledge-*.md` files.

## 1. Bootstrap

- Run `bash skills/docs-core/scripts/scan-project.sh [project-root]`.
- Capture output summary and candidate file lists.
- Confirm whether repository is mono-repo or single package.

## 2. Mandatory Direct Reads

Read content (not only filenames) from:

- `README*`, `CONTRIBUTING*`, `CHANGELOG*` when present.
- Runtime manifests (`package.json`, `pyproject.toml`, `go.mod`, etc.).
- Lock file and tool configs (`tsconfig`, lint, format, test config).
- At least one entry-point per runtime surface (web/API/worker/CLI).
- At least one API file (`route`, `router`, `controller`, `handler`).
- At least one domain model file (`model`, `schema`, `entity`).
- At least one standards/pipeline file (`.github/workflows`, commit/lint configs).

## 3. Targeted Search Passes

Run search for each class of evidence:

- Architecture terms: `controller|service|repository|use-case|domain|module|adapter|middleware|handler`
- API terms: `route|router|endpoint|graphql|openapi|swagger|trpc`
- Data terms: `model|schema|entity|migration|prisma|typeorm|sequelize|mongoose|sql`
- Standards terms: `eslint|prettier|editorconfig|commitlint|husky|lint-staged|test`
- Business terms: extract domain nouns from docs/comments and confirm in code.

## 4. Evidence Ledger

Build a ledger before writing documents.

| Claim Area | Evidence Files | Confidence |
|-----------|----------------|------------|
| Architecture | {paths} | High/Medium/Low |
| Domain Model | {paths} | High/Medium/Low |
| Standards | {paths} | High/Medium/Low |
| Source Structure | {paths} | High/Medium/Low |

Rules:

- Every major section must have at least one evidence file.
- If confidence is low, say so explicitly and add follow-up actions.
- Do not infer undocumented behavior.

## 5. Anti-Shallow Checks

- Script output must not be the only input source.
- Generated claims must be traceable to real files.
- Unknowns must go to `Known Gaps and Open Questions`.
- Never leave unresolved placeholders.

## 6. Update Safety

For existing docs in UPDATE mode:

- Preserve accurate historical context.
- Append and revise selectively when possible.
- Controlled rewrite is allowed only if structure is broken or stale >70%.
- If controlled rewrite is used, preserve valid legacy context under:
  `## Legacy Notes (Preserved Context)`.
