---
description: 🔒 Focused Test — Comprehensive QA with enforced context optimization
version: "1.0"
category: validation
execution-mode: execute
---

# /test:focus — Focus Comprehensive Testing

> **MISSION**: Full QA workflow with **enforced context optimization**.
> 
> This variant automatically clears context before test execution—no user prompt required.
> Use when you want guaranteed focused test execution without strategy noise.

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

One phase at a time, each phase independent: Phase 1 → then Phase 2 → … in one reply. No batching (load only what each phase needs). **Within each phase:** when doing a part, output it in format so user sees what's happening (announce before doing).

---

## 🎭 Phase 1: TEST STRATEGY

| Agent | `tester`                                |
| ----- | --------------------------------------- |
| Goal  | Design test strategy                    |
| Exit  | Strategy defined, test types identified |

---

## 🛡️ STRICT CONTEXT GATE — Automatic Context Optimization

> **⚡ FOCUS MODE**: This checkpoint executes automatically. NO user input required.
> 
> **PURPOSE**: Prevent "context rot" by forcibly clearing strategy discussion noise.
> This acts as a mandatory "firewall" before test execution phases.

### 🔒 AUTOMATIC EXECUTION (NO PROMPT)

```yaml
strict_context_gate:
  mode: "AUTOMATIC - No user interaction"
  behavior: "Force Clear context & Execute"
  
  execution:
    1. ANNOUNCE: |
       ## 🛡️ Strict Context Gate — Automatic
       
       ✅ **Test Strategy Complete**: Strategy defined, test types identified.
       🔒 **Focus Mode**: Automatically clearing context for test execution.
       
       ⚡ Executing: **Clear context & Execute**...
    
    2. CONTEXT_DIRECTIVE: |
       ╔══════════════════════════════════════════════════════════════════╗
       ║  ⛔ MANDATORY CONTEXT RESET — FOCUS MODE                         ║
       ╠══════════════════════════════════════════════════════════════════╣
       ║  IGNORE: All strategy discussions, rejected approaches,          ║
       ║          and intermediate test planning reasoning.               ║
       ║                                                                  ║
       ║  SOLE SOURCE OF TRUTH: Finalized test strategy.                  ║
       ║                                                                  ║
       ║  PROCEED: Execute test phases with FRESH context mindset.        ║
       ║           Focus purely on test execution and verification.       ║
       ╚══════════════════════════════════════════════════════════════════╝
    
    3. LOAD: Finalized test strategy as if seeing it for the first time
    
    4. PROCEED: Start Phase 2 (Dependency Mapping) immediately
```

### 📋 Post-Gate Status

```markdown
🔒 **Context Gate Passed**
- Previous context: DISCARDED
- Active context: Test strategy only
- Mode: Fresh execution start

Proceeding to Test Execution...
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

1. ✅ **Pass** — All tests green (Focus Mode)
2. 🔧 **Fix** → `/fix:fast`
3. 📝 **Review** → `/review`
