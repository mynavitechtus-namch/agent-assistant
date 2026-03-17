# Deep Audit Checklist for Docs-Audit

Use this checklist before generating or updating `./documents/audit/*.md`.

## 1. Bootstrap

- Run `bash skills/docs-audit/scripts/scan-audit-surface.sh [project-root]`.
- Capture the summary of entry points, risky patterns, config files, and high-value candidates.
- Confirm whether the repository is a single package or multi-package layout.
- Ensure scanner output is readable and binary-safe (no opaque/base64 dump lines).

## 2. Mandatory Direct Reads

Read content, not only filenames, from:
- `README*`, `CHANGELOG*`, `CONTRIBUTING*`, `SECURITY*`, policy files, and architecture docs when present.
- Runtime manifests and lock files.
- CI, deploy, workflow, and environment configuration files.
- At least one file for each of these surfaces if present:
  - auth/session
  - routing or endpoints
  - persistence or schema
  - secrets/config
  - logging/telemetry
  - external integrations

## 3. Targeted Search Passes

Search for:
- auth and session terms
- secrets and credentials terms
- crypto terms
- validation and sanitization terms
- privacy and retention terms
- suppressions and risky ignores
- dependency and supply-chain signals
- ingress and egress points

## 4. Evidence Ledger Rules

- Every major claim must map to explicit files.
- Prefer line-anchored references where possible (for example `path/file.ts#L42`).
- Unknowns must be called out explicitly.
- Control claims without evidence are not allowed.
- Compliance claims must say whether evidence is verified, partial, unknown, or not applicable.

## 5. Severity Discipline

- Do not label something critical without impact and exploitability rationale.
- Distinguish vulnerabilities, code smells, weak signals, and missing evidence.
- If exploitability cannot be verified, use cautious wording.

## 6. Update Safety

- Preserve accurate historical context.
- Prefer targeted revision over full rewrite.
- Use controlled rewrite only if the document is structurally broken or mostly stale.
- If rewriting, keep valid context under `## Legacy Notes (Preserved Context)`.

## 7. Final Integrity Checks

- Remove all unresolved placeholders (`{...}`, `TODO`, `TBD`, `TBA`).
- Ensure severity and finding IDs are consistent across all 4 audit documents.
- Ensure every strict score section includes confidence and score-cap reasoning.