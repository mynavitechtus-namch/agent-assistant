---
description: ⚡⚡⚡ Full Test — Comprehensive QA with quality gates
version: "1.0"
category: validation
execution-mode: execute
---

# /test:hard — Comprehensive Testing

> **MISSION**: Full QA workflow with quality gates and coverage reporting.

<scope>$ARGUMENTS</scope>

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

## 📁 PLAN CHECKPOINT VERIFICATION

```
IF ./reports/plans/PLAN-{scope}.md exists:
  1. READ plan completely
  2. EXTRACT all checkpoints
  3. FOR EACH checkpoint → Create test
  4. OUTPUT: "Checkpoint Coverage: X/Y"
```

---

## ⛔ INCREMENTAL EXECUTION (MANDATORY)

One phase at a time, each phase independent: Phase 1 → then Phase 2 → … in one reply. No batching (load only what each phase needs). **Within each phase:** when doing a part, output it in format so user sees what’s happening (announce before doing).

---

## 🎭 Phase 1: TEST STRATEGY

| Agent | `tester`                                |
| ----- | --------------------------------------- |
| Goal  | Design test strategy                    |
| Exit  | Strategy defined, test types identified |

---

## 🛡️ VERIFICATION CHECKPOINT — Context Optimization

> **PURPOSE**: Prevent "context rot" by clearing strategy discussion before test execution.
> 
> Test strategy discussions may include rejected approaches that can confuse execution.
> This checkpoint ensures clean handoff to test execution phases.

### ⚡ OPTIONS (Present to User)

```markdown
## 🛡️ Context Optimization Checkpoint

**Test Strategy Complete** — Strategy defined, ready for execution.

**Choose how to proceed:**

| Option | Action | Description |
|--------|--------|-------------|
| **1. 🚀 Clear context & Execute** | `RECOMMENDED` | Fresh start: Focus on strategy, ignore discussion history |
| **2. ⏸️ Review Strategy** | `SAFE` | Clear context, show strategy summary, wait for approval |
| **3. ⚠️ Continue (No Clear)** | `RISKY` | Keep full history (may affect test focus) |

⏳ Awaiting selection...
```

### 🔄 EXECUTION BEHAVIOR

```yaml
option_1_clear_execute:
  behavior: "RECOMMENDED - Clean execution"
  steps:
    1. ACKNOWLEDGE: "🚀 Context optimized. Executing test strategy."
    2. CONTEXT_DIRECTIVE: |
       ⛔ IGNORE strategy discussion and rejected approaches.
       ✅ FINALIZED STRATEGY is SOLE SOURCE OF TRUTH.
    3. PROCEED: Continue to test execution phases

option_2_review_strategy:
  behavior: "Clear and show summary"
  steps:
    1. ACKNOWLEDGE: "⏸️ Context cleared."
    2. OUTPUT: Display strategy summary
    3. WAIT: For user approval

option_3_continue_no_clear:
  behavior: "Proceed with caution"
  steps:
    1. WARN: "⚠️ Discussion history retained."
    2. PROCEED: Continue with existing context
```

---

## 🎭 Phase 2: DEPENDENCY MAPPING

| Agent | `scouter`                              |
| ----- | -------------------------------------- |
| Goal  | Map test dependencies                  |
| Exit  | Dependencies mapped, environment ready |

---

## 🎭 Phase 3: TEST EXECUTION

| Agent        | `tester`                                                        |
| ------------ | --------------------------------------------------------------- |
| Prerequisite | READ PLAN file if exists                                        |
| Goal         | Run full test suite                                             |
| Exit         | All tests run, coverage measured, checkpoint mapping documented |

---

## 🎭 Phase 4: FAILURE ANALYSIS (IF FAILURES)

| Agent   | `debugger`             |
| ------- | ---------------------- |
| Trigger | If failures exist      |
| Goal    | Analyze failures       |
| Exit    | Root causes identified |

---

## 🎭 Phase 5: QUALITY GATES

| Agent | `tester`                          |
| ----- | --------------------------------- |
| Goal  | Verify quality gates              |
| Exit  | All gates pass, coverage adequate |

---

## COMPLETION

Present test report with:

1. ✅ **Pass** — All tests green
2. 🔧 **Fix** → `/fix:fast`
3. 📝 **Review** → `/review`
