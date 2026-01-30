---
description: ⚡⚡⚡ Full Debug — Deep investigation for complex issues
version: "1.0"
category: debugging
execution-mode: execute
---

# /debug:hard — Deep Investigation

> **MISSION**: Thorough investigation for complex or intermittent issues.

<issue>$ARGUMENTS</issue>

---

## 🛑 PRE-FLIGHT (DO FIRST — BLOCKS PHASE 1)

**LOAD now** (in order; path `./rules/` or `~/.{TOOL}/skills/agent-assistant/rules/`):

1. ORCHESTRATION-LAWS.md
2. ADAPTIVE-EXECUTION.md
3. EXECUTION-PROTOCOL.md

**⛔ Do not run Phase 1 until all are loaded.** Follow **all** rules in those files; they override any conflicting instructions in this file.

---

## 🔀 TIERED EXECUTION

| Tier       | When               | Action                       |
| ---------- | ------------------ | ---------------------------- |
| **TIER 1** | runSubagent EXISTS | Invoke sub-agent (MANDATORY) |
| **TIER 2** | Tool MISSING       | EMBODY agent file (FALLBACK) |

---

## 📁 DELIVERABLE FILES

| Agent    | Output                              |
| -------- | ----------------------------------- |
| debugger | `./reports/debugs/DEBUG-{issue}.md` |

All files in `./reports/` → English only.

---

## ⛔ INCREMENTAL EXECUTION (MANDATORY)

One phase at a time, each phase independent: Phase 1 → then Phase 2 → … in one reply. No batching (load only what each phase needs). **Within each phase:** when doing a part, output it in format so user sees what’s happening (announce before doing).

---

## 🎭 Phase 1: INFORMATION GATHERING

| Agent | `scouter`                                 |
| ----- | ----------------------------------------- |
| Goal  | Gather context and reproduction steps     |
| Exit  | Context gathered, reproduction documented |

---

## 🎭 Phase 2: HYPOTHESIS FORMATION

| Agent | `debugger`                          |
| ----- | ----------------------------------- |
| Goal  | Form and rank hypotheses            |
| Exit  | Hypotheses documented with evidence |

---

## 🎭 Phase 3: ROOT CAUSE ANALYSIS

| Agent  | `debugger`                                      |
| ------ | ----------------------------------------------- |
| Goal   | Deep investigation                              |
| Output | `./reports/debugs/DEBUG-{issue}.md`             |
| Exit   | Root cause identified, failure chain documented |

---

## 🎭 Phase 4: SOLUTION DESIGN

| Agent | `planner`                               |
| ----- | --------------------------------------- |
| Goal  | Design fix strategy                     |
| Exit  | Fix approach defined with rollback plan |

---

## 🛡️ VERIFICATION CHECKPOINT — Context Optimization

> **PURPOSE**: Prevent "context rot" by clearing noisy debugging/analysis history before fix implementation.
> 
> Deep investigation sessions fill context with hypotheses and failed attempts that can confuse implementation.
> This checkpoint acts as a "firewall" before handing off to fix workflows.

### ⚡ OPTIONS (Present to User)

```markdown
## 🛡️ Context Optimization Checkpoint

**Debug Analysis Complete** — Root cause identified, fix strategy designed.

**Choose how to proceed:**

| Option | Action | Description |
|--------|--------|-------------|
| **1. 🚀 Clear context & Fix** | `RECOMMENDED` | Fresh start: Ignore debug history, proceed with fix strategy only |
| **2. ⏸️ Review First** | `SAFE` | Clear context, show fix summary, wait for approval |
| **3. ⚠️ Continue (No Clear)** | `RISKY` | Keep debug history (may cause fix drift) |

⏳ Awaiting selection...
```

### 🔄 EXECUTION BEHAVIOR

```yaml
option_1_clear_fix:
  behavior: "RECOMMENDED - Clean handoff to fix"
  steps:
    1. ACKNOWLEDGE: "🚀 Context optimized. Fix strategy ready."
    2. CONTEXT_DIRECTIVE: |
       ⛔ IGNORE all debugging hypotheses and failed investigation paths.
       ✅ FIX STRATEGY is SOLE SOURCE OF TRUTH.
    3. OUTPUT: "Run `/fix:focus` to implement with clean context."

option_2_review_first:
  behavior: "Clear and show summary"
  steps:
    1. ACKNOWLEDGE: "⏸️ Context cleared."
    2. OUTPUT: Display root cause + fix strategy summary
    3. WAIT: For user approval

option_3_continue_no_clear:
  behavior: "Proceed with caution"
  steps:
    1. WARN: "⚠️ Debug history retained. Watch for hypothesis drift."
    2. PROCEED: Complete workflow with existing context
```

---

## COMPLETION

Present findings with:

1. ✅ **Root Cause** — Identified
2. 🔧 **Fix** → `/fix:hard`
3. 📝 **Document** → `/docs:core`
