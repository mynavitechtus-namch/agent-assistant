#!/usr/bin/env bash
# scan-audit-surface.sh — Audit-oriented repository scanner for docs-audit.
# Produces a compact summary of risky surfaces, candidate files, and evidence signals.
# Usage: bash scan-audit-surface.sh [project-root]

set -euo pipefail
LC_ALL=C

PROJECT_ROOT="${1:-.}"
PROJECT_ROOT="$(cd "$PROJECT_ROOT" && pwd)"
PROJECT_NAME="$(basename "$PROJECT_ROOT")"

if git -C "$PROJECT_ROOT" rev-parse --show-toplevel >/dev/null 2>&1; then
  REPO_ROOT="$(git -C "$PROJECT_ROOT" rev-parse --show-toplevel)"
else
  REPO_ROOT="$PROJECT_ROOT"
fi

MAX_HITS=60

has_rg() {
  command -v rg >/dev/null 2>&1
}

clip_lines() {
  awk '{ if (length($0) > 360) print substr($0, 1, 360) "... [truncated]"; else print }'
}

filter_noise() {
  grep -Evi '\.(svg|png|jpg|jpeg|gif|webp|ico):|package-lock\.json:|pnpm-lock\.yaml:|yarn\.lock:|/public/|/assets/' || true
}

filter_repo_noise() {
  # Reduce non-runtime noise from docs, examples, generated reports, and story/demo assets.
  grep -Evi '/(documents|reports|examples|example|fixtures|storybook|stories|__snapshots__|__mocks__|mock-data|samples)/' || true
}

filter_semantic_noise() {
  # Drop obvious prose/UI-copy lines that frequently contain keywords but are not security controls.
  grep -Evi 'description\s*[:=]|title\s*[:=]|label\s*[:=]|placeholder\s*[:=]|aria-label\s*[:=]|\b(opens in new tab|workflow|feature|marketing|documentation|hero|subtitle|tagline|learn more|discover)\b|<meta\s|<title\s|\bexample\s*[:=]|\bcommand\s*[:=]|\/(cook|fix|test|plan|review|docs|deploy)(:|\b)' || true
}

filter_hit_paths() {
  # Keep likely executable/config files to reduce documentation-only noise.
  grep -E '\.(c|cc|cpp|cs|go|java|js|jsx|mjs|cjs|ts|tsx|py|rb|php|rs|swift|kt|kts|scala|sh|bash|zsh|ps1|sql|ya?ml|json|toml|ini|conf|env|properties|xml):' || true
}

normalize_hit_paths() {
  sed "s|$PROJECT_ROOT|.|g"
}

find_filtered() {
  find "$PROJECT_ROOT" "$@" \
    ! -path '*/node_modules/*' \
    ! -path '*/.git/*' \
    ! -path '*/dist/*' \
    ! -path '*/build/*' \
    ! -path '*/coverage/*' \
    ! -path '*/.next/*' \
    ! -path '*/.turbo/*' \
    ! -path '*/__pycache__/*' \
    ! -path '*/venv/*' \
    ! -path '*/.venv/*' \
    ! -path '*/.cache/*' \
    ! -path '*/tmp/*' \
    ! -path '*/target/*' \
    ! -path '*/.idea/*' \
    ! -path '*/.vscode/*' \
    ! -path '*/documents/*' \
    ! -path '*/reports/*' \
    ! -path '*/examples/*' \
    ! -path '*/example/*' \
    ! -path '*/fixtures/*' \
    ! -path '*/storybook/*' \
    ! -path '*/stories/*' \
    ! -path '*/__snapshots__/*' \
    ! -path '*/__mocks__/*' \
    ! -path '*/mock-data/*' 2>/dev/null
}

print_hits() {
  local pattern="$1"
  local limit="$2"

  if has_rg; then
    rg -n --hidden --no-messages --smart-case --max-columns 300 --max-columns-preview \
      --glob '!**/.git/**' \
      --glob '!**/node_modules/**' \
      --glob '!**/dist/**' \
      --glob '!**/build/**' \
      --glob '!**/coverage/**' \
      --glob '!**/.next/**' \
      --glob '!**/.turbo/**' \
      --glob '!**/venv/**' \
      --glob '!**/.venv/**' \
      --glob '!**/.cache/**' \
      --glob '!**/tmp/**' \
      --glob '!**/target/**' \
      --glob '!**/.idea/**' \
      --glob '!**/.vscode/**' \
      --glob '!**/documents/**' \
      --glob '!**/reports/**' \
      --glob '!**/examples/**' \
      --glob '!**/example/**' \
      --glob '!**/fixtures/**' \
      --glob '!**/storybook/**' \
      --glob '!**/stories/**' \
      --glob '!**/__snapshots__/**' \
      --glob '!**/__mocks__/**' \
      --glob '!**/mock-data/**' \
      --glob '!**/*.min.*' \
      -e "$pattern" "$PROJECT_ROOT" | normalize_hit_paths | filter_hit_paths | filter_repo_noise | filter_semantic_noise | filter_noise | head -n "$limit" | clip_lines || true
  else
    grep -RInEI --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=dist --exclude-dir=build \
      --exclude-dir=coverage --exclude-dir=.next --exclude-dir=.turbo --exclude-dir=venv --exclude-dir=.venv \
      --exclude-dir=.cache --exclude-dir=tmp --exclude-dir=target --exclude-dir=.idea --exclude-dir=.vscode \
      --exclude-dir=documents --exclude-dir=reports --exclude-dir=examples --exclude-dir=example \
      --exclude-dir=fixtures --exclude-dir=storybook --exclude-dir=stories --exclude-dir=__snapshots__ \
      --exclude-dir=__mocks__ --exclude-dir=mock-data --exclude='*.min.*' "$pattern" "$PROJECT_ROOT" 2>/dev/null | normalize_hit_paths | filter_hit_paths | filter_repo_noise | filter_semantic_noise | filter_noise | head -n "$limit" | clip_lines || true
  fi
}

echo "========================================"
echo "  AUDIT SURFACE SCAN: $PROJECT_NAME"
echo "  Root: $PROJECT_ROOT"
echo "  Date: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
if has_rg; then
  echo "  Search Engine: ripgrep"
else
  echo "  Search Engine: grep (-I binary-safe mode)"
fi
echo "========================================"
echo ""

echo "## 1. Entry Points and High-Value Files"
echo ""
find "$PROJECT_ROOT" -maxdepth 1 -type f \( \
  -name 'README.md' -o -name 'CHANGELOG.md' -o -name 'CONTRIBUTING.md' -o -name 'SECURITY.md' -o \
  -name 'package.json' -o -name 'requirements.txt' -o -name 'pyproject.toml' -o -name 'go.mod' -o -name 'Cargo.toml' -o \
  -name 'Dockerfile' -o -name 'docker-compose.yml' -o -name 'docker-compose.yaml' -o \
  -name '.env*' -o -name '*.pem' -o -name '*.key' -o -name '*.crt' \
\) 2>/dev/null | sed "s|$PROJECT_ROOT|.|g" | sort
find_filtered -maxdepth 3 -type f \( \
  -name 'index.*' -o -name 'main.*' -o -name 'app.*' -o -name 'server.*' -o \
  -iname '*auth*' -o -iname '*session*' -o -iname '*middleware*' -o -iname '*config*' -o \
  -iname '*route*' -o -iname '*controller*' -o -iname '*schema*' -o -iname '*model*' -o -iname '*entity*' \
\) | sed "s|$PROJECT_ROOT|.|g" | sort | head -100
echo ""

echo "## 2. Sensitive Pattern Hits"
echo ""
echo "### Auth / Session"
print_hits '\bauth[A-Z_][A-Za-z0-9_]*\b|\bsession\b|\bcookie\b|\bjwt\b|\boauth\b|\bcsrf\b|\bcors\b|\brbac\b|\bacl\b|\bauthoriz(e|ation)\b|\b(refreshToken|accessToken)\b' "$MAX_HITS"
echo ""
echo "### Secrets / Credentials"
print_hits 'api[_-]?key|private[_-]?key|client[_-]?secret|access[_-]?key|\bbearer\b|\bpassword\b|\bsecret\b|\b(jwt|access|refresh)[_-]?token\b|\btoken\b\s*[:=]' "$MAX_HITS"
echo ""
echo "### Crypto"
print_hits '\bencrypt\b|\bdecrypt\b|\bhash\b|\bsign\b|\bverify\b|\bcrypto\b|\btls\b|\bhmac\b|\bsha(1|256|512)\b' "$MAX_HITS"
echo ""
echo "### Validation / Sanitization"
print_hits '\bvalidate\b|\bsanitize\b|\bescape\b|\b(zod|joi|pydantic|ajv|yup)\b|json[_ -]?schema|openapi|swagger' "$MAX_HITS"
echo ""

echo "## 3. Privacy and Dataflow Signals"
echo ""
echo "### Privacy Terms"
print_hits '\bpii\b|\bprivacy\b|\bconsent\b|\bretention\b|personal data|data subject|\bgdpr\b|\bssn\b|\bdob\b|\bemail\b' "$MAX_HITS"
echo ""
echo "### Ingress / Egress Signals"
print_hits '\bwebhook\b|\bingress\b|\begress\b|fetch\(|axios\.|baseURL|apiBaseUrl|endpoint\s*[:=]|new URL\(|\bgrpc\b|\bs3\b|\bbucket\b|\bqueue\b|\bkafka\b|\bsns\b|\bsqs\b|\b(callbackUrl|returnUrl|redirectUri)\b' "$MAX_HITS"
echo ""

echo "## 4. Risky Suppressions and Workarounds"
echo ""
print_hits 'TODO|FIXME|HACK|ts-ignore|eslint-disable|nosec|suppress|bypass|allowlist|skipLibCheck|securityExceptions' "$MAX_HITS"
echo ""

echo "## 5. CI / Deployment / Supply Chain"
echo ""
find_filtered -type f \( \
  -path '*/.github/workflows/*' -o -name '.gitlab-ci.yml' -o -name 'Jenkinsfile' -o -name '.circleci/config.yml' -o -name 'azure-pipelines.yml' -o \
  -name 'package-lock.json' -o -name 'pnpm-lock.yaml' -o -name 'yarn.lock' -o -name 'poetry.lock' -o -name 'Cargo.lock' -o -name 'go.sum' -o \
  -name 'Dockerfile' -o -name 'docker-compose.yml' -o -name 'docker-compose.yaml' -o -name 'kustomization.yaml' -o -name '*.tf' \
\) | sed "s|$PROJECT_ROOT|.|g" | sort | head -160
echo ""
echo "### Dependency Vulnerability / Pinning Signals"
print_hits 'npm audit|pip-audit|safety|snyk|dependabot|renovate|\bpinned\b|\bpinning\b|checksum|integrity|lockfile' "$MAX_HITS"
echo ""

echo "## 6. Candidate Files for Direct Read"
echo ""
find_filtered -type f \( \
  -iname '*auth*' -o -iname '*session*' -o -iname '*middleware*' -o -iname '*config*' -o -iname '*route*' -o -iname '*controller*' -o \
  -iname '*schema*' -o -iname '*model*' -o -iname '*entity*' -o -iname '*policy*' -o -iname '*audit*' -o -iname '*security*' \
\) | sed "s|$PROJECT_ROOT|.|g" | sort | head -180
echo ""

echo "## 7. Existing Audit Documents"
echo ""
FOUND_AUDIT_DOCS=0
if [ -d "$PROJECT_ROOT/documents/audit" ]; then
  ls -1 "$PROJECT_ROOT/documents/audit" | sed 's|^|  ./documents/audit/|'
  FOUND_AUDIT_DOCS=1
fi
if [ "$REPO_ROOT" != "$PROJECT_ROOT" ] && [ -d "$REPO_ROOT/documents/audit" ]; then
  if [ "$FOUND_AUDIT_DOCS" -eq 0 ]; then
    echo "  (from repo root)"
  fi
  ls -1 "$REPO_ROOT/documents/audit" | sed 's|^|  [repo]/documents/audit/|'
  FOUND_AUDIT_DOCS=1
fi
if [ "$FOUND_AUDIT_DOCS" -eq 0 ]; then
  echo "  ./documents/audit/ not found"
fi