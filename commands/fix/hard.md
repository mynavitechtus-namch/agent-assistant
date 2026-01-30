---
description: ⚡⚡⚡ Full Fix — Complete issue resolution with research
version: "1.0"
category: debugging
execution-mode: execute
---

# /fix:hard — Complete Issue Resolution

> **MISSION**: Full resolution workflow with research, planning, and validation.

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

| Tier | When | Action |
|------|------|--------|
| **TIER 1** | runSubagent EXISTS | Invoke sub-agent (MANDATORY) |
| **TIER 2** | Tool MISSING | EMBODY agent file (FALLBACK) |

**❌ Anti-Lazy**: Never use TIER 2 when TIER 1 tool available.

---

## 📁 DELIVERABLE FILES

| Agent | Output |
|-------|--------|
| debugger | `./reports/debugs/DEBUG-{issue}.md` |
| researcher | `./reports/researchers/RESEARCH-{issue}.md` |

All files in `./reports/` → English only.

---

## ⛔ INCREMENTAL EXECUTION (MANDATORY)

One phase at a time, each phase independent: Phase 1 → then Phase 2 → … in one reply. No batching (load only what each phase needs). **Within each phase:** when doing a part, output it in format so user sees what’s happening (announce before doing). Format: rules/EXECUTION-PROTOCOL.md § Phase output structure.

---

## 🎭 Phase 1: DEEP ANALYSIS

| Agent | `debugger` |
|-------|------------|
| Goal | Full root cause analysis |
| Exit | Root cause identified, impact assessed, failure chain documented |

---

## 🎭 Phase 2: RESEARCH

| Agent | `researcher` |
|-------|--------------|
| Goal | Research solution patterns |
| Exit | Solutions researched, best approach identified |

---

## 🎭 Phase 3: FIX PLANNING

| Agent | `planner` |
|-------|-----------|
| Goal | Create fix strategy with rollback |
| Exit | Plan created, rollback included |

---

## 🛡️ VERIFICATION CHECKPOINT — Context Optimization

> **PURPOSE**: Prevent "context rot" by clearing noisy debugging/planning history before implementation.
> 
> Long-running analysis sessions fill context with noise that degrades code generation quality.
> This checkpoint acts as a "firewall" between Planning and Implementation phases.

### ⚡ OPTIONS (Present to User)

```markdown
## 🛡️ Context Optimization Checkpoint

**Planning Complete** — Fix plan created with rollback strategy.

**Choose how to proceed with implementation:**

| Option | Action | Description |
|--------|--------|-------------|
| **1. 🚀 Clear context & Auto-Implement** | `RECOMMENDED` | Fresh start: Reload Plan, ignore chat history, begin fix immediately |
| **2. ⏸️ Clear context & Manual** | `SAFE` | Clear context, reload Plan, pause for your command before coding |
| **3. ⚠️ Continue (No Clear)** | `RISKY` | Proceed with full history attached (may cause hallucination) |

⏳ Awaiting selection...
```

### 🔄 EXECUTION BEHAVIOR

```yaml
option_1_clear_auto_implement:
  behavior: "RECOMMENDED - Simulate fresh start"
  steps:
    1. ACKNOWLEDGE: "🚀 Executing Clear context & Auto-Implement..."
    2. CONTEXT_DIRECTIVE: |
       ⛔ IGNORE all previous chat messages and reasoning chains.
       ✅ RELOAD: Fix plan as SOLE SOURCE OF TRUTH.
       ✅ PROCEED: Begin Phase 4 (Implementation) immediately.
    3. EXECUTE: Start Implementation phase with fresh context mindset

option_2_clear_manual:
  behavior: "Clear and wait for explicit command"
  steps:
    1. ACKNOWLEDGE: "⏸️ Context cleared. Plan reloaded."
    2. CONTEXT_DIRECTIVE: |
       ⛔ IGNORE all previous chat messages and reasoning chains.
       ✅ RELOAD: Fix plan as SOLE SOURCE OF TRUTH.
    3. OUTPUT: "Ready for fix implementation. Type `/continue` or give specific instructions."
    4. WAIT: For user command before proceeding

option_3_continue_no_clear:
  behavior: "Proceed with caution - context rot risk"
  steps:
    1. WARN: "⚠️ Continuing with full history. Higher hallucination risk."
    2. PROCEED: Continue to Phase 4 with existing context
```

---

## 🎭 Phase 4: IMPLEMENTATION

| Agent | `tech-lead` → specialists |
|-------|---------------------------|
| Goal | Execute fix plan |
| Exit | Fix implemented, changes documented |

---

## 🎭 Phase 5: VALIDATION

| Agent | `tester` |
|-------|----------|
| Goal | Comprehensive validation |
| Exit | Issue resolved, tests pass, no regression |

---

## 🎭 Phase 5.5: ROLLBACK VERIFICATION (IF CRITICAL)

| Agent | `devops-engineer` |
|-------|-------------------|
| Trigger | Fix affects production or is critical |
| Goal | Verify rollback plan |
| Exit | Rollback documented, tested, recovery time estimated |

---

## COMPLETION

Present fix report with:

1. ✅ **Fixed** — Issue resolved
2. 🧪 **Test** → `/test`
3. 📝 **Docs** → `/docs:core`
