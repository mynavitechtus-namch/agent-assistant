---
description: 🔒 Focused Development — Full development cycle with enforced context optimization
version: "1.0"
category: engineering
execution-mode: execute
---

# /code:focus — Focus Development Cycle

> **MISSION**: Execute complete development workflow with **enforced context optimization**.
>
> This variant automatically clears context before implementation—no user prompt required.
> Use when you want guaranteed clean implementation without context rot risk.

<task>$ARGUMENTS</task>

---

## 🛑 PRE-FLIGHT (DO FIRST — BLOCKS PHASE 1)

**LOAD now** (in order; path `./rules/` or `~/.{TOOL}/skills/agent-assistant/rules/`):

1. ORCHESTRATION-LAWS.md
2. ADAPTIVE-EXECUTION.md
3. EXECUTION-PROTOCOL.md

**⛔ Do not run Phase 1 until all are loaded.** Follow **all** rules in those files; they override any conflicting instructions in this file.

---

## 🔀 TIERED EXECUTION PROTOCOL (MANDATORY)

> **Reference**: `{RULES_PATH}/ADAPTIVE-EXECUTION.md`

```yaml
tiered_execution:
  principle: "Sub-agent FIRST (Tier 1). EMBODY ONLY on system failure (Tier 2)."

  tool_discovery: "Check runSubagent availability BEFORE first delegation"

  for_each_phase:
    TIER_1_MANDATORY: "IF tool exists → MUST use SUB_AGENT_DELEGATION"
    TIER_2_FALLBACK: "ONLY on system error—NOT complexity/preference/speed"

  anti_lazy_fallback:
    - ❌ NEVER use Tier 2 when Tier 1 tool is available
    - ✅ ALWAYS attempt Tier 1 first when tool exists
    - ✅ ALWAYS log justification for Tier 2 fallback
```

---

## ⚠️ CRITICAL: PHASE CONTINUITY RULES

```yaml
phase_continuity:
  rule: "Each phase MUST reference and follow outputs from prior phases"

  check_for_files:
    - "./reports/brainstorms/BRAINSTORM-{task}.md"
    - "./reports/scouts/SCOUT-{task}.md"
    - "./reports/plans/PLAN-{task}.md"

  enforcement:
    - Phase 3 (Planning) MUST incorporate Scout findings
    - Phase 4 (Implementation) MUST follow the Plan file exactly
    - Phase 5 (Testing) MUST verify all plan checkpoints
    - If prior phase file missing → Agent MUST create it
```

All files in `./reports/` → English only.

---

## ⛔ INCREMENTAL EXECUTION (MANDATORY)

One phase at a time, each phase independent: Phase 1 → then Phase 2 → … in one reply. No batching (load only what each phase needs). **Within each phase:** when doing a part, output it in format so user sees what's happening (announce before doing).

---

## 🎭 Phase 1: REQUIREMENTS ANALYSIS

| Attribute   | Value                             |
| ----------- | --------------------------------- |
| **Agent**   | `brainstormer`                    |
| **Goal**    | Clarify requirements if ambiguous |
| **Trigger** | If requirements unclear           |

### ⚡ TIERED EXECUTION

**TIER 1 (MANDATORY when tool exists):**

> Invoke runSubagent for `brainstormer`. Context: ISOLATED.

**TIER 2 (FALLBACK on system error only):**

> Load `{AGENTS_PATH}/brainstormer.md`
> EMBODY [brainstormer] — Requires logged system error justification.

**Exit Criteria:**

- [ ] Requirements clear
- [ ] Scope defined
- [ ] Acceptance criteria established
- [ ] **METHODOLOGY CHECK**: Output aligns with `brainstormer` Thinking Protocol

---

## 🎭 Phase 2: CODEBASE ANALYSIS

| Attribute | Value                         |
| --------- | ----------------------------- |
| **Agent** | `scouter`                     |
| **Goal**  | Full codebase context mapping |

### ⚡ TIERED EXECUTION

**TIER 1 (MANDATORY when tool exists):**

> Invoke runSubagent for `scouter`. Context: ISOLATED.

**TIER 2 (FALLBACK on system error only):**

> Load `{AGENTS_PATH}/scouter.md`
> EMBODY [scouter] — Requires logged system error justification.

**Exit Criteria:**

- [ ] Architecture understood
- [ ] Patterns documented
- [ ] Integration points identified
- [ ] **METHODOLOGY CHECK**: Output aligns with `scouter` Thinking Protocol

---

## 🎭 Phase 3: IMPLEMENTATION PLANNING

| Attribute | Value                      |
| --------- | -------------------------- |
| **Agent** | `planner`                  |
| **Goal**  | Create implementation plan |

### ⚡ TIERED EXECUTION

**TIER 1 (MANDATORY when tool exists):**

> Invoke runSubagent for `planner`. Context: ISOLATED.

**TIER 2 (FALLBACK on system error only):**

> Load `{AGENTS_PATH}/planner.md`
> EMBODY [planner] — Requires logged system error justification.

**Exit Criteria:**

- [ ] Plan created
- [ ] Steps defined
- [ ] Risks identified
- [ ] **METHODOLOGY CHECK**: Output aligns with `planner` Thinking Protocol

---

## 🛡️ STRICT CONTEXT GATE — Automatic Context Optimization

> **⚡ FOCUS MODE**: This checkpoint executes automatically. NO user input required.
>
> **PURPOSE**: Prevent "context rot" by forcibly clearing noisy planning history.
> This acts as a mandatory "firewall" between Planning and Implementation phases.

### 🔒 AUTOMATIC EXECUTION (NO PROMPT)

```yaml
strict_context_gate:
  mode: "AUTOMATIC - No user interaction"
  behavior: "Force Clear context & Auto-Implement"

  execution:
    1. ANNOUNCE: |
      ## 🛡️ Strict Context Gate — Automatic

      ✅ **Plan Complete**: `./reports/plans/PLAN-{task}.md`
      🔒 **Focus Mode**: Automatically clearing context for implementation.

      ⚡ Executing: **Clear context & Auto-Implement**...

    2. CONTEXT_DIRECTIVE: |
      ╔══════════════════════════════════════════════════════════════════╗
      ║  ⛔ MANDATORY CONTEXT RESET — FOCUS MODE                        ║
      ╠══════════════════════════════════════════════════════════════════╣
      ║  IGNORE: All previous chat messages, reasoning chains,           ║
      ║          brainstorming discussions, research explorations,       ║
      ║          rejected alternatives, and intermediate thinking.       ║
      ║                                                                  ║
      ║  SOLE SOURCE OF TRUTH: `./reports/plans/PLAN-{task}.md`          ║
      ║                                                                  ║
      ║  PROCEED: Begin Implementation phase with FRESH context mindset. ║
      ║           Treat this as a NEW conversation starting from Plan.   ║
      ╚══════════════════════════════════════════════════════════════════╝

    3. LOAD: Read Plan file completely as if seeing it for the first time

    4. PROCEED: Start Phase 4 (Implementation) immediately
```

### 📋 Post-Gate Status

```markdown
🔒 **Context Gate Passed**

- Previous context: DISCARDED
- Active context: Plan file only
- Mode: Fresh implementation start

Proceeding to Implementation...
```

---

## 🎭 Phase 4: IMPLEMENTATION

| Attribute | Value                               |
| --------- | ----------------------------------- |
| **Agent** | `tech-lead` → routes to specialists |
| **Goal**  | Execute plan with specialist agents |

### ⚡ TIERED EXECUTION

**TIER 1 (MANDATORY when tool exists):**

> Invoke runSubagent for `tech-lead`. Context: ISOLATED.
> Tech-lead will spawn specialist subagents as needed.

**TIER 2 (FALLBACK on system error only):**

> Load `{AGENTS_PATH}/tech-lead.md`
> EMBODY [tech-lead] — Requires logged system error justification.
> Then recursively EMBODY specialists as needed.

### ⚡ FOCUS ADHERENCE DIRECTIVE

```
1. READ plan completely BEFORE any implementation
2. FOR EACH plan step:
   a. Implement EXACTLY as specified
   b. Mark complete: `- [ ]` → `- [x]`
3. IF deviation needed:
   a. STOP
   b. REQUEST Re-Planning
   c. DO NOT proceed with own interpretation
```

**Exit Criteria:**

- [ ] All plan steps executed
- [ ] Code complete
- [ ] Documentation updated
- [ ] **Each plan step has corresponding implementation**
- [ ] **No unauthorized deviations**
- [ ] **METHODOLOGY CHECK**: Output aligns with `tech-lead` Thinking Protocol

---

## 🎭 Phase 5: TESTING

| Attribute | Value                 |
| --------- | --------------------- |
| **Agent** | `tester`              |
| **Goal**  | Comprehensive testing |

### ⚡ TIERED EXECUTION

**TIER 1 (MANDATORY when tool exists):**

> Invoke runSubagent for `tester`. Context: ISOLATED.

**TIER 2 (FALLBACK on system error only):**

> Load `{AGENTS_PATH}/tester.md`
> EMBODY [tester] — Requires logged system error justification.

**Exit Criteria:**

- [ ] Tests written
- [ ] All tests pass
- [ ] Coverage adequate
- [ ] **METHODOLOGY CHECK**: Output aligns with `tester` Thinking Protocol

---

## 🎭 Phase 6: REVIEW

| Attribute | Value               |
| --------- | ------------------- |
| **Agent** | `reviewer`          |
| **Goal**  | Code quality review |

### ⚡ TIERED EXECUTION

**TIER 1 (MANDATORY when tool exists):**

> Invoke runSubagent for `reviewer`. Context: ISOLATED.

**TIER 2 (FALLBACK on system error only):**

> Load `{AGENTS_PATH}/reviewer.md`
> EMBODY [reviewer] — Requires logged system error justification.

**Exit Criteria:**

- [ ] Code reviewed
- [ ] Standards met
- [ ] No blocking issues
- [ ] **METHODOLOGY CHECK**: Output aligns with `reviewer` Thinking Protocol

---

## COMPLETION

Present implementation report with:

1. ✅ **Done** — Feature complete (Focus Mode)
2. 🚀 **Deploy** → `/deploy:preview`
3. 📝 **Docs** → `/docs:core`
