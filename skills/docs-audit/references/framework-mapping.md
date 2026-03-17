# Audit Framework Mapping Guidance

Use this reference to keep framework mapping practical and evidence-based.

## Mapping Rules

- Map only to what the repository evidence can support.
- Mark each item as one of: `Verified`, `Partial`, `Unknown`, `N/A`.
- Never claim formal certification or legal compliance.
- If evidence is process-level but not code-level, say that clearly.
- Prefer `Evidence` entries with file and line anchors where practical.

## Recommended Framework Use

### OWASP Top 10

Use for high-level application security categories such as broken access control, crypto failures, insecure design, vulnerable components, logging failures, SSRF, and injection-related issues.

### OWASP ASVS

Use when a more control-oriented mapping is needed, especially around authentication, session management, validation, access control, logging, and configuration.

### CWE Top 25

Use for issue taxonomy where a finding maps clearly to a common weakness type.

### NIST CSF

Use for broader control themes such as identify, protect, detect, respond, and recover. Keep this practical and avoid over-claiming organizational maturity from code alone.

### CIS Secure Software Practices

Use for engineering practices tied to dependency control, secure configuration, CI/CD hardening, secrets handling, and logging.

### ISO 27001-Oriented Themes

Use for control themes such as access management, secure development, asset management, logging, and supplier dependencies. Phrase these as alignment signals, not certification outcomes.

### GDPR or Privacy-Oriented Principles

Use when personal data handling is present or likely. Focus on data minimization, retention, transparency, sharing, and sensitive-data exposure risks.

## Output Pattern

Recommended table format:

| Control or Finding | Framework | Status | Evidence | Notes |
| --- | --- | --- | --- | --- |
| {item} | {framework mapping} | {Verified/Partial/Unknown/N/A} | `{path}` | {notes} |

## Common Failure Modes

- Mapping secure code patterns directly to full compliance claims.
- Treating missing evidence as proof of compliance.
- Conflating privacy signals with legal advice.
- Using framework language without tying it back to repository evidence.
- Marking `Verified` when evidence is only indirect or inferred.