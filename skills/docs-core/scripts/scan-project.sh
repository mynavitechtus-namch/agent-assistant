#!/usr/bin/env bash
# scan-project.sh — Lightweight project scanner for docs-core skill
# Produces a compact summary of project structure, tech stack, and metrics.
# Designed to minimize context window usage on large codebases.
#
# Usage: bash scan-project.sh [project-root]
# Default: current directory

set -euo pipefail

PROJECT_ROOT="${1:-.}"
PROJECT_ROOT="$(cd "$PROJECT_ROOT" && pwd)"
PROJECT_NAME="$(basename "$PROJECT_ROOT")"

echo "========================================"
echo "  PROJECT SCAN: $PROJECT_NAME"
echo "  Root: ."
echo "  Date: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
echo "========================================"
echo ""

# ─────────────────────────────────────────────
# 1. DIRECTORY TREE (depth 3, directories only)
# ─────────────────────────────────────────────
echo "## 1. Directory Structure (depth 3)"
echo ""
if command -v tree &>/dev/null; then
  tree -d -L 3 --noreport -I 'node_modules|.git|__pycache__|.next|dist|build|.venv|venv|.tox|coverage|.cache|.turbo' "$PROJECT_ROOT" 2>/dev/null | sed "s|$PROJECT_ROOT|.|g" || true
else
  find "$PROJECT_ROOT" -maxdepth 3 -type d \
    ! -name 'node_modules' \
    ! -name '.git' \
    ! -name '__pycache__' \
    ! -name '.next' \
    ! -name 'dist' \
    ! -name 'build' \
    ! -name '.venv' \
    ! -name 'venv' \
    ! -name '.cache' \
    ! -name '.turbo' \
    ! -path '*/node_modules/*' \
    ! -path '*/.git/*' \
    ! -path '*/__pycache__/*' \
    ! -path '*/.next/*' \
    ! -path '*/dist/*' \
    ! -path '*/build/*' \
    ! -path '*/.venv/*' \
    ! -path '*/venv/*' \
    ! -path '*/.cache/*' \
    ! -path '*/.turbo/*' \
    -print 2>/dev/null | sed "s|$PROJECT_ROOT|.|g" | sort
fi
echo ""

# ─────────────────────────────────────────────
# 2. FILE COUNTS BY EXTENSION
# ─────────────────────────────────────────────
echo "## 2. File Counts by Extension"
echo ""
find "$PROJECT_ROOT" -type f \
  ! -path '*/node_modules/*' \
  ! -path '*/.git/*' \
  ! -path '*/__pycache__/*' \
  ! -path '*/.next/*' \
  ! -path '*/dist/*' \
  ! -path '*/build/*' \
  ! -path '*/.venv/*' \
  ! -path '*/venv/*' \
  ! -path '*/.cache/*' \
  ! -path '*/.turbo/*' \
  2>/dev/null \
  | awk -F/ '{f=$NF; if (f ~ /\./) {sub(/.*\./, "", f); print f} else {print "[noext]"}}' \
  | sort | uniq -c | sort -rn | head -25 \
  | awk '{ext=$2; prefix=(ext=="[noext]")?"":"."; printf "  %-6s  %s%s\n", $1, prefix, ext}'
echo ""

TOTAL_FILES=$(find "$PROJECT_ROOT" -type f \
  ! -name '.DS_Store' \
  ! -path '*/node_modules/*' \
  ! -path '*/.git/*' \
  ! -path '*/__pycache__/*' \
  ! -path '*/.next/*' \
  ! -path '*/dist/*' \
  ! -path '*/build/*' \
  ! -path '*/.venv/*' \
  ! -path '*/venv/*' \
  2>/dev/null | wc -l | tr -d ' ')
echo "  Total files: $TOTAL_FILES"
echo ""

# ─────────────────────────────────────────────
# 3. TECH STACK DETECTION
# ─────────────────────────────────────────────
echo "## 3. Tech Stack Detection"
echo ""

# Package managers and manifests
for manifest in "package.json:Node.js/JavaScript" \
  "requirements.txt:Python (pip)" \
  "pyproject.toml:Python (modern)" \
  "Pipfile:Python (pipenv)" \
  "Cargo.toml:Rust" \
  "go.mod:Go" \
  "pom.xml:Java (Maven)" \
  "build.gradle:Java (Gradle)" \
  "build.gradle.kts:Kotlin (Gradle)" \
  "Gemfile:Ruby" \
  "composer.json:PHP" \
  "*.csproj:C# (.NET)" \
  "pubspec.yaml:Dart/Flutter" \
  "mix.exs:Elixir"; do
  
  file="${manifest%%:*}"
  label="${manifest##*:}"
  if find "$PROJECT_ROOT" -maxdepth 4 -name "$file" -print -quit 2>/dev/null | grep -q .; then
    echo "  ✅ $label ($file found)"
  fi
done
echo ""

# Framework detection from package.json
if [ -f "$PROJECT_ROOT/package.json" ]; then
  echo "### Detected from package.json:"
  for fw in "next:Next.js" \
    "react:React" \
    "vue:Vue.js" \
    "nuxt:Nuxt" \
    "svelte:Svelte" \
    "angular:Angular" \
    "express:Express.js" \
    "fastify:Fastify" \
    "nestjs:NestJS" \
    "hono:Hono" \
    "prisma:Prisma ORM" \
    "drizzle-orm:Drizzle ORM" \
    "typeorm:TypeORM" \
    "sequelize:Sequelize" \
    "mongoose:Mongoose" \
    "tailwindcss:Tailwind CSS" \
    "typescript:TypeScript" \
    "vitest:Vitest" \
    "jest:Jest" \
    "playwright:Playwright" \
    "cypress:Cypress" \
    "eslint:ESLint" \
    "prettier:Prettier" \
    "stripe:Stripe" \
    "socket.io:Socket.IO" \
    "graphql:GraphQL" \
    "trpc:tRPC"; do
    
    pkg="${fw%%:*}"
    label="${fw##*:}"
    if grep -q "\"$pkg\"" "$PROJECT_ROOT/package.json" 2>/dev/null; then
      echo "    ✅ $label"
    fi
  done
  echo ""
fi

# Infrastructure detection
echo "### Infrastructure:"
[ -f "$PROJECT_ROOT/Dockerfile" ] && echo "  ✅ Docker"
[ -f "$PROJECT_ROOT/docker-compose.yml" ] || [ -f "$PROJECT_ROOT/docker-compose.yaml" ] && echo "  ✅ Docker Compose"
[ -d "$PROJECT_ROOT/.github/workflows" ] && echo "  ✅ GitHub Actions"
[ -f "$PROJECT_ROOT/.gitlab-ci.yml" ] && echo "  ✅ GitLab CI"
[ -f "$PROJECT_ROOT/Jenkinsfile" ] && echo "  ✅ Jenkins"
[ -f "$PROJECT_ROOT/vercel.json" ] && echo "  ✅ Vercel"
[ -f "$PROJECT_ROOT/netlify.toml" ] && echo "  ✅ Netlify"
[ -f "$PROJECT_ROOT/fly.toml" ] && echo "  ✅ Fly.io"
[ -f "$PROJECT_ROOT/terraform.tf" ] || [ -d "$PROJECT_ROOT/terraform" ] && echo "  ✅ Terraform"
[ -f "$PROJECT_ROOT/pulumi.yaml" ] && echo "  ✅ Pulumi"
echo ""

# ─────────────────────────────────────────────
# 4. ENTRY POINTS
# ─────────────────────────────────────────────
echo "## 4. Entry Points"
echo ""
for entry in "index.ts" "index.js" "main.ts" "main.js" "app.ts" "app.js" \
  "server.ts" "server.js" "main.py" "app.py" "manage.py" "main.go" \
  "main.rs" "Program.cs" "Application.java"; do
  found=$(find "$PROJECT_ROOT" -maxdepth 3 -name "$entry" \
    ! -path '*/node_modules/*' \
    ! -path '*/.git/*' \
    ! -path '*/dist/*' \
    ! -path '*/build/*' \
    2>/dev/null | head -3)
  if [ -n "$found" ]; then
    echo "$found" | sed "s|$PROJECT_ROOT|.|g" | while read -r f; do
      echo "  📄 $f"
    done
  fi
done
echo ""

# ─────────────────────────────────────────────
# 5. CONFIGURATION FILES
# ─────────────────────────────────────────────
echo "## 5. Configuration Files"
echo ""
for cfg in "tsconfig.json" "jsconfig.json" ".eslintrc*" "eslint.config*" \
  ".prettierrc*" "prettier.config*" ".editorconfig" "vite.config*" \
  "next.config*" "webpack.config*" "rollup.config*" "babel.config*" \
  ".babelrc" "jest.config*" "vitest.config*" "playwright.config*" \
  "tailwind.config*" "postcss.config*" ".env.example" ".env.local" \
  ".releaserc*" "commitlint.config*" "lint-staged.config*" ".husky"; do
  found=$(find "$PROJECT_ROOT" -maxdepth 2 -name "$cfg" \
    ! -path '*/node_modules/*' \
    2>/dev/null | head -1)
  if [ -n "$found" ]; then
    echo "  ⚙️  $(echo "$found" | sed "s|$PROJECT_ROOT|.|g")"
  fi
done
echo ""

# ─────────────────────────────────────────────
# 6. LINE COUNTS (top 20 largest source files)
# ─────────────────────────────────────────────
echo "## 6. Largest Source Files (top 20)"
echo ""
find "$PROJECT_ROOT" -type f \( \
  -name '*.ts' -o -name '*.tsx' -o -name '*.js' -o -name '*.jsx' \
  -o -name '*.py' -o -name '*.go' -o -name '*.rs' -o -name '*.java' \
  -o -name '*.rb' -o -name '*.php' -o -name '*.cs' -o -name '*.swift' \
  -o -name '*.kt' -o -name '*.dart' -o -name '*.vue' -o -name '*.svelte' \
  \) \
  ! -path '*/node_modules/*' \
  ! -path '*/.git/*' \
  ! -path '*/dist/*' \
  ! -path '*/build/*' \
  ! -path '*/.next/*' \
  ! -path '*/.venv/*' \
  -print0 2>/dev/null \
  | xargs -0 wc -l 2>/dev/null \
  | sort -rn \
  | head -21 \
  | tail -20 \
  | sed "s|$PROJECT_ROOT|.|g" \
  | awk '{printf "  %6d  %s\n", $1, $2}'
echo ""

# ─────────────────────────────────────────────
# 7. EXISTING DOCUMENTATION
# ─────────────────────────────────────────────
echo "## 7. Existing Documentation"
echo ""
if [ -d "$PROJECT_ROOT/documents" ]; then
  echo "  ./documents/ exists:"
  ls -1 "$PROJECT_ROOT/documents/" 2>/dev/null | while read -r f; do
    echo "    📄 $f"
  done
else
  echo "  ❌ ./documents/ not found"
fi
echo ""

[ -f "$PROJECT_ROOT/README.md" ] && echo "  ✅ README.md exists" || echo "  ❌ README.md missing"
[ -f "$PROJECT_ROOT/CONTRIBUTING.md" ] && echo "  ✅ CONTRIBUTING.md exists"
[ -f "$PROJECT_ROOT/CHANGELOG.md" ] && echo "  ✅ CHANGELOG.md exists"
echo ""

# ─────────────────────────────────────────────
# 8. HIGH-VALUE CANDIDATE FILES
# ─────────────────────────────────────────────
echo "## 8. High-Value Candidate Files"
echo ""

find "$PROJECT_ROOT" -type f \( \
  -name 'README.md' -o -name 'README.*' -o -name 'CONTRIBUTING.md' -o -name 'CHANGELOG.md' -o \
  -name 'package.json' -o -name 'pyproject.toml' -o -name 'requirements.txt' -o -name 'go.mod' -o \
  -name 'Cargo.toml' -o -name 'pom.xml' -o -name 'build.gradle' -o -name 'docker-compose.yml' -o \
  -name 'Dockerfile' -o -name '.env.example' -o -name 'tsconfig.json' -o -name 'next.config.*' -o \
  -name 'vite.config.*' -o -name 'eslint.config.*' -o -name '.eslintrc*' -o -name '.prettierrc*' \
\) \
  ! -path '*/node_modules/*' ! -path '*/.git/*' \
  2>/dev/null | sed "s|$PROJECT_ROOT|.|g" | sort | head -80 || true
echo ""

echo "### API/Domain candidate files"
find "$PROJECT_ROOT" -type f \
  ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' ! -path '*/build/*' \
  \( -iname '*route*' -o -iname '*router*' -o -iname '*controller*' -o -iname '*service*' -o -iname '*usecase*' -o -iname '*domain*' -o -iname '*model*' -o -iname '*schema*' -o -iname '*entity*' -o -iname '*migration*' \) \
  2>/dev/null | sed "s|$PROJECT_ROOT|.|g" | sort | head -120 || true
echo ""

# ─────────────────────────────────────────────
# 9. DOMAIN AND BUSINESS CLUES
# ─────────────────────────────────────────────
echo "## 9. Domain and Business Clues"
echo ""

echo "### Frequent domain nouns from docs/comments (top 40)"
find "$PROJECT_ROOT" -type f \( -name '*.md' -o -name '*.ts' -o -name '*.tsx' -o -name '*.js' -o -name '*.jsx' -o -name '*.py' \) \
  ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' ! -path '*/build/*' \
  -print0 2>/dev/null \
  | xargs -0 grep -hEo '[A-Za-z][A-Za-z_-]{3,}' 2>/dev/null \
  | tr '[:upper:]' '[:lower:]' \
  | grep -vE '^(this|that|with|from|have|your|they|them|http|https|const|class|function|return|import|export|true|false|null|undefined|string|number|object|array|table|value|values|file|files|path|paths)$' \
  | sort | uniq -c | sort -rn | head -40 \
  | awk '{printf "  %-6s  %s\n", $1, $2}' || true
echo ""

echo "### TODO/FIXME/HACK signals"
find "$PROJECT_ROOT" -type f \( -name '*.ts' -o -name '*.tsx' -o -name '*.js' -o -name '*.jsx' -o -name '*.py' -o -name '*.go' -o -name '*.java' \) \
  ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' ! -path '*/build/*' \
  -print0 2>/dev/null \
  | xargs -0 grep -nHE 'TODO|FIXME|HACK|XXX' 2>/dev/null \
  | sed "s|$PROJECT_ROOT|.|g" | head -120 || true
echo ""

# ─────────────────────────────────────────────
# 10. RECENT CHANGE SIGNALS (GIT)
# ─────────────────────────────────────────────
echo "## 10. Recent Change Signals"
echo ""
if [ -d "$PROJECT_ROOT/.git" ] && command -v git &>/dev/null; then
  (
    cd "$PROJECT_ROOT"
    echo "### Recently changed files (last 30 commits)"
    git --no-pager log --name-only --pretty=format: -n 30 2>/dev/null \
      | sed '/^$/d' \
      | grep -vE '^(node_modules/|dist/|build/|\.next/)' \
      | sort | uniq -c | sort -rn | head -40 \
      | awk '{printf "  %-6s  %s\n", $1, $2}' || true
    echo ""
  )
else
  echo "  ℹ️ Git metadata unavailable"
fi
echo ""

# ─────────────────────────────────────────────
# 11. SUMMARY
# ─────────────────────────────────────────────
echo "========================================"
echo "  SCAN COMPLETE"
echo "  Files: $TOTAL_FILES"
DIR_COUNT=$(find "$PROJECT_ROOT" -type d \
  ! -name 'node_modules' \
  ! -name '.git' \
  ! -name '.next' \
  ! -name 'dist' \
  ! -name 'build' \
  ! -path '*/node_modules/*' \
  ! -path '*/.git/*' \
  ! -path '*/.next/*' \
  ! -path '*/dist/*' \
  ! -path '*/build/*' \
  2>/dev/null | wc -l | tr -d ' ')
echo "  Directories: $DIR_COUNT"
echo "========================================"
