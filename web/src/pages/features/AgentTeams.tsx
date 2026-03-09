import { motion } from 'framer-motion'
import { Button, Card, CardContent, Badge, Section, SectionHeader } from '../../components/ui'
import { PageSideDecorations, GradientBackground } from '../../components/decorations'
import { SEO, pageSEO } from '../../components/seo'
import { Terminal } from '../../components/terminal'

// ---------------------------------------------------------------------------
// Data
// ---------------------------------------------------------------------------

const teams = [
  { domain: 'backend', icon: '⚙️', techLead: 'tech-lead', executor: 'backend-engineer', reviewerFocus: 'security + performance', color: 'red' as const },
  { domain: 'frontend', icon: '🎨', techLead: 'tech-lead', executor: 'frontend-engineer', reviewerFocus: 'design + performance', color: 'cyan' as const },
  { domain: 'fullstack', icon: '🔗', techLead: 'tech-lead', executor: 'backend + frontend-engineer', reviewerFocus: 'security + performance', color: 'purple' as const },
  { domain: 'database', icon: '🗄️', techLead: 'tech-lead', executor: 'database-architect', reviewerFocus: 'security + performance', color: 'orange' as const },
  { domain: 'research', icon: '🔬', techLead: 'researcher', executor: 'scouter', reviewerFocus: 'critical evaluator', color: 'green' as const },
  { domain: 'planning', icon: '📋', techLead: 'planner', executor: 'researcher', reviewerFocus: 'feasibility critic', color: 'cyan' as const },
  { domain: 'qa', icon: '🧪', techLead: 'tester', executor: 'tester', reviewerFocus: 'security + performance', color: 'green' as const },
  { domain: 'design', icon: '✏️', techLead: 'designer', executor: 'frontend-engineer', reviewerFocus: 'UX + accessibility', color: 'purple' as const },
  { domain: 'debug', icon: '🐛', techLead: 'debugger', executor: 'backend-engineer', reviewerFocus: 'root-cause validator', color: 'red' as const },
  { domain: 'devops', icon: '🚀', techLead: 'devops-engineer', executor: 'backend-engineer', reviewerFocus: 'security', color: 'orange' as const },
  { domain: 'security', icon: '🔒', techLead: 'security-engineer', executor: 'backend-engineer', reviewerFocus: 'pen-test mindset', color: 'red' as const },
  { domain: 'game', icon: '🎮', techLead: 'tech-lead', executor: 'game-engineer', reviewerFocus: 'game arch + performance', color: 'purple' as const },
  { domain: 'mobile', icon: '📱', techLead: 'tech-lead', executor: 'mobile-engineer', reviewerFocus: 'UX + platform + performance', color: 'cyan' as const },
  { domain: 'performance', icon: '⚡', techLead: 'performance-engineer', executor: 'backend-engineer', reviewerFocus: 'measurement validation', color: 'orange' as const },
  { domain: 'docs', icon: '📄', techLead: 'docs-manager', executor: 'researcher', reviewerFocus: 'accuracy + completeness', color: 'green' as const },
  { domain: 'project', icon: '📊', techLead: 'project-manager', executor: 'business-analyst', reviewerFocus: 'technical feasibility', color: 'cyan' as const },
  { domain: 'report', icon: '📈', techLead: 'reporter', executor: 'scouter', reviewerFocus: 'data accuracy + insight', color: 'purple' as const },
]

const debateSteps = [
  { step: 1, title: 'Executor Implements', description: 'Executor delivers implementation. Reviewer receives the work.', icon: '💻', badge: 'Execute' },
  { step: 2, title: 'Reviewer Critiques', description: 'Reviewer challenges with specific, evidence-based objections.', icon: '🔍', badge: 'Challenge' },
  { step: 3, title: 'Executor Defends or Fixes', description: 'Executor DEFENDS with evidence OR acknowledges and FIXES. No performative agreement.', icon: '🛡️', badge: 'Defend / Fix' },
  { step: 4, title: 'Consensus or Escalation', description: 'Reviewer approves → PASS. If FAIL after 3 rounds → Tech Lead ARBITRATES (binding decision).', icon: '⚖️', badge: 'Resolve' },
]

const consensusPaths = [
  { name: 'Clean Pass', icon: '✅', description: 'Reviewer approves on first review. No issues found.', color: 'from-[rgba(0,255,136,0.2)] to-[rgba(0,212,255,0.1)]', borderColor: 'border-[rgba(0,255,136,0.3)]' },
  { name: 'Resolved Pass', icon: '🔄', description: 'After defense with evidence or fix, Reviewer approves.', color: 'from-[rgba(255,136,68,0.2)] to-[rgba(136,68,255,0.1)]', borderColor: 'border-[rgba(255,136,68,0.3)]' },
  { name: 'Arbitrated Pass', icon: '⚖️', description: 'Tech Lead overrides after max 3 debate rounds. Binding decision.', color: 'from-[rgba(255,68,68,0.2)] to-[rgba(136,68,255,0.1)]', borderColor: 'border-[rgba(255,68,68,0.3)]' },
]

const teamCommands = [
  '/cook:team', '/fix:team', '/debug:team', '/test:team',
  '/review:team', '/plan:team', '/design:team', '/report:team', '/deploy:team',
]

const stats = [
  { value: '17', label: 'Domain Teams', icon: '🏢' },
  { value: '51', label: 'Specialized Agents', icon: '🤖' },
  { value: '3', label: 'Roles per Team', icon: '🔺' },
  { value: '3', label: 'Max Debate Rounds', icon: '🔄' },
  { value: '9', label: 'Team Commands', icon: '⌨️' },
]

// ---------------------------------------------------------------------------
// Component
// ---------------------------------------------------------------------------

export default function AgentTeams() {
  return (
    <main className="min-h-screen bg-bg-primary">
      <SEO {...pageSEO.agentTeams} />

      {/* ── Hero ───────────────────────────────────────────────────── */}
      <Section background="primary" spacing="xl" className="relative overflow-hidden">
        <GradientBackground theme="agents" />
        <PageSideDecorations theme="agents" />
        <div className="text-center max-w-3xl mx-auto relative z-10">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            <Badge variant="green" size="lg" className="mb-6">
              New Feature
            </Badge>
            <h1 className="heading-hero mb-6">
              Agent Teams — Golden Triangle
            </h1>
            <p className="text-body text-lg mb-8">
              Adversarial collaboration with 17 specialized teams, each composed of a
              Tech Lead, Executor, and Reviewer. Structured debate produces stronger output
              than any single agent can achieve alone.
            </p>
          </motion.div>

          {/* Stats bar */}
          <motion.div
            className="grid grid-cols-2 sm:grid-cols-5 gap-4 mt-4"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.2 }}
          >
            {stats.map((stat) => (
              <div
                key={stat.label}
                className="rounded-xl bg-[var(--color-bg-secondary)] border border-[var(--color-border-secondary)] px-4 py-4"
              >
                <span className="text-2xl block mb-1">{stat.icon}</span>
                <span className="text-2xl font-bold bg-gradient-to-r from-[var(--color-gradient-red)] to-[var(--color-gradient-purple)] bg-clip-text text-transparent">
                  {stat.value}
                </span>
                <span className="block text-xs text-[var(--color-text-muted)] mt-0.5">{stat.label}</span>
              </div>
            ))}
          </motion.div>
        </div>
      </Section>

      {/* ── Golden Triangle Architecture ───────────────────────────── */}
      <Section background="secondary" spacing="lg">
        <SectionHeader
          title="The Golden Triangle"
          description="Every team runs the same adversarial pattern. Three roles, one goal: quality through structured debate."
        />

        <motion.div
          className="max-w-3xl mx-auto"
          initial={{ opacity: 0 }}
          whileInView={{ opacity: 1 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <Card variant="elevated">
            <CardContent>
              {/* Triangle visual */}
              <div className="relative py-8">
                {/* SVG triangle lines */}
                <svg
                  className="absolute inset-0 w-full h-full pointer-events-none"
                  viewBox="0 0 600 340"
                  preserveAspectRatio="xMidYMid meet"
                  aria-hidden="true"
                >
                  {/* Triangle edges */}
                  <line x1="300" y1="55" x2="105" y2="275" stroke="rgba(136,68,255,0.25)" strokeWidth="2" strokeDasharray="6 4" />
                  <line x1="300" y1="55" x2="495" y2="275" stroke="rgba(255,136,68,0.25)" strokeWidth="2" strokeDasharray="6 4" />
                  <line x1="105" y1="275" x2="495" y2="275" stroke="rgba(0,255,136,0.25)" strokeWidth="2" strokeDasharray="6 4" />

                  {/* Arrow labels along edges */}
                  <text x="180" y="155" fill="rgba(136,68,255,0.5)" fontSize="10" textAnchor="middle" transform="rotate(-55 180 155)">delegates</text>
                  <text x="420" y="155" fill="rgba(255,136,68,0.5)" fontSize="10" textAnchor="middle" transform="rotate(55 420 155)">reviews</text>
                  <text x="300" y="300" fill="rgba(0,255,136,0.5)" fontSize="10" textAnchor="middle">mailbox ↔ debate</text>
                </svg>

                {/* Triangle nodes */}
                <div className="flex flex-col items-center gap-16 relative z-10">
                  {/* Top: Tech Lead */}
                  <motion.div
                    className="text-center"
                    initial={{ opacity: 0, y: -20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    transition={{ delay: 0.1 }}
                  >
                    <div className="w-20 h-20 mx-auto rounded-full bg-gradient-to-br from-[var(--color-gradient-red)] to-[var(--color-gradient-purple)] flex items-center justify-center mb-3 shadow-lg shadow-[rgba(136,68,255,0.25)]">
                      <span className="text-3xl">👑</span>
                    </div>
                    <Badge variant="purple" size="md" className="mb-2">Tech Lead</Badge>
                    <p className="text-sm text-[var(--color-text-secondary)] max-w-[200px]">
                      Decomposes · Arbitrates · Synthesizes
                    </p>
                    <p className="text-xs text-[var(--color-gradient-red)] mt-1 font-semibold uppercase tracking-wider">Final Authority</p>
                  </motion.div>

                  {/* Bottom row: Executor & Reviewer */}
                  <div className="flex justify-between w-full max-w-lg">
                    {/* Executor */}
                    <motion.div
                      className="text-center"
                      initial={{ opacity: 0, x: -30 }}
                      whileInView={{ opacity: 1, x: 0 }}
                      viewport={{ once: true }}
                      transition={{ delay: 0.25 }}
                    >
                      <div className="w-20 h-20 mx-auto rounded-full bg-gradient-to-br from-[var(--color-gradient-green)] to-[var(--color-gradient-cyan)] flex items-center justify-center mb-3 shadow-lg shadow-[rgba(0,255,136,0.25)]">
                        <span className="text-3xl">🛠️</span>
                      </div>
                      <Badge variant="green" size="md" className="mb-2">Executor</Badge>
                      <p className="text-sm text-[var(--color-text-secondary)] max-w-[180px]">
                        Builds · Defends implementation
                      </p>
                    </motion.div>

                    {/* Reviewer */}
                    <motion.div
                      className="text-center"
                      initial={{ opacity: 0, x: 30 }}
                      whileInView={{ opacity: 1, x: 0 }}
                      viewport={{ once: true }}
                      transition={{ delay: 0.25 }}
                    >
                      <div className="w-20 h-20 mx-auto rounded-full bg-gradient-to-br from-[var(--color-gradient-orange)] to-[var(--color-gradient-red)] flex items-center justify-center mb-3 shadow-lg shadow-[rgba(255,136,68,0.25)]">
                        <span className="text-3xl">🔎</span>
                      </div>
                      <Badge variant="orange" size="md" className="mb-2">Reviewer</Badge>
                      <p className="text-sm text-[var(--color-text-secondary)] max-w-[180px]">
                        Challenges · Validates quality
                      </p>
                    </motion.div>
                  </div>
                </div>
              </div>

              {/* Mailbox callout */}
              <div className="mt-6 p-4 rounded-lg bg-[var(--color-bg-primary)] border border-[var(--color-border-secondary)] text-center">
                <p className="text-sm text-[var(--color-text-secondary)]">
                  <span className="text-[var(--color-text-accent)] font-semibold">📬 Mailbox Protocol</span> — All communication flows through structured mailbox messages. No ad-hoc chatter, every exchange is recorded and traceable.
                </p>
              </div>
            </CardContent>
          </Card>
        </motion.div>
      </Section>

      {/* ── 17 Teams Roster ────────────────────────────────────────── */}
      <Section background="primary" spacing="lg">
        <SectionHeader
          title="17 Domain Teams"
          description="Each team is purpose-built for its domain with the right specialists in every role."
        />

        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {teams.map((team, index) => (
            <motion.div
              key={team.domain}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.4, delay: index * 0.04 }}
            >
              <Card hoverable className="h-full">
                <CardContent>
                  <div className="flex items-center gap-3 mb-4">
                    <span className="text-2xl">{team.icon}</span>
                    <div>
                      <Badge variant={team.color} size="sm">{team.domain}</Badge>
                    </div>
                  </div>

                  <div className="space-y-2 text-sm">
                    <div className="flex items-start gap-2">
                      <span className="text-[var(--color-gradient-purple)] shrink-0">👑</span>
                      <div>
                        <span className="text-[var(--color-text-muted)] text-xs uppercase tracking-wider">Tech Lead</span>
                        <p className="text-[var(--color-text-primary)] font-medium">{team.techLead}</p>
                      </div>
                    </div>
                    <div className="flex items-start gap-2">
                      <span className="text-[var(--color-gradient-green)] shrink-0">🛠️</span>
                      <div>
                        <span className="text-[var(--color-text-muted)] text-xs uppercase tracking-wider">Executor</span>
                        <p className="text-[var(--color-text-primary)] font-medium">{team.executor}</p>
                      </div>
                    </div>
                    <div className="flex items-start gap-2">
                      <span className="text-[var(--color-gradient-orange)] shrink-0">🔎</span>
                      <div>
                        <span className="text-[var(--color-text-muted)] text-xs uppercase tracking-wider">Reviewer Focus</span>
                        <p className="text-[var(--color-text-secondary)]">{team.reviewerFocus}</p>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>
      </Section>

      {/* ── Debate Mechanism ───────────────────────────────────────── */}
      <Section background="secondary" spacing="lg">
        <SectionHeader
          title="Structured Debate"
          description="Quality through adversarial collaboration, not rubber-stamping."
        />

        <div className="max-w-3xl mx-auto">
          <div className="relative">
            {/* Vertical timeline line */}
            <div className="absolute left-8 top-0 bottom-0 w-0.5 bg-gradient-to-b from-[var(--color-gradient-green)] via-[var(--color-gradient-orange)] to-[var(--color-gradient-purple)] hidden md:block" />

            <div className="space-y-8">
              {debateSteps.map((step, index) => (
                <motion.div
                  key={step.step}
                  className="relative"
                  initial={{ opacity: 0, x: -20 }}
                  whileInView={{ opacity: 1, x: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: index * 0.12 }}
                >
                  <div className="flex gap-6">
                    <div className="flex-shrink-0 z-10">
                      <div className="w-16 h-16 rounded-full bg-gradient-to-br from-[var(--color-gradient-red)] to-[var(--color-gradient-purple)] flex items-center justify-center shadow-lg">
                        <span className="text-2xl">{step.icon}</span>
                      </div>
                    </div>

                    <Card className="flex-1">
                      <CardContent>
                        <div className="flex items-center gap-3 mb-2">
                          <Badge variant="orange" size="sm">{step.badge}</Badge>
                          <h3 className="heading-card">{step.title}</h3>
                        </div>
                        <p className="text-body">{step.description}</p>
                      </CardContent>
                    </Card>
                  </div>
                </motion.div>
              ))}

              {/* Outcome callout */}
              <motion.div
                className="relative"
                initial={{ opacity: 0, scale: 0.95 }}
                whileInView={{ opacity: 1, scale: 1 }}
                viewport={{ once: true }}
                transition={{ duration: 0.5, delay: 0.5 }}
              >
                <div className="flex gap-6">
                  <div className="flex-shrink-0 z-10">
                    <div className="w-16 h-16 rounded-full bg-gradient-to-br from-[var(--color-gradient-green)] to-[var(--color-gradient-cyan)] flex items-center justify-center shadow-lg">
                      <span className="text-2xl">✅</span>
                    </div>
                  </div>
                  <div className="flex-1 p-6 rounded-xl bg-gradient-to-r from-[rgba(0,255,136,0.1)] to-[rgba(0,212,255,0.05)] border border-[rgba(0,255,136,0.3)]">
                    <h3 className="heading-card text-[var(--color-text-accent)] mb-2">Consensus Reached</h3>
                    <p className="text-body">Output has been challenged, defended, and verified. Ship with confidence.</p>
                  </div>
                </div>
              </motion.div>
            </div>
          </div>
        </div>
      </Section>

      {/* ── Consensus Protocol ─────────────────────────────────────── */}
      <Section background="primary" spacing="lg">
        <SectionHeader
          title="Consensus Protocol"
          description="Three paths to agreement — every debate resolves."
        />

        <div className="grid gap-6 md:grid-cols-3 max-w-4xl mx-auto">
          {consensusPaths.map((path, index) => (
            <motion.div
              key={path.name}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: index * 0.15 }}
            >
              <div className={`h-full rounded-xl bg-gradient-to-br ${path.color} border ${path.borderColor} p-6 text-center`}>
                <span className="text-4xl block mb-4">{path.icon}</span>
                <h3 className="heading-card mb-2">{path.name}</h3>
                <p className="text-body text-sm">{path.description}</p>
              </div>
            </motion.div>
          ))}
        </div>
      </Section>

      {/* ── :team Variant ──────────────────────────────────────────── */}
      <Section background="secondary" spacing="lg">
        <SectionHeader
          title="The :team Variant"
          description="Append :team to any supported command to activate the Golden Triangle for that workflow."
        />

        <div className="max-w-3xl mx-auto">
          {/* Terminal example */}
          <motion.div
            className="mb-8"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
          >
            <Terminal
              command="/cook:team add JWT authentication with refresh tokens"
              title="Agent Assistant — Team Mode"
            />
          </motion.div>

          {/* Command grid */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.15 }}
          >
            <Card>
              <CardContent>
                <h3 className="heading-card mb-4">9 Team-Enabled Commands</h3>
                <div className="flex flex-wrap gap-3">
                  {teamCommands.map((cmd) => (
                    <span
                      key={cmd}
                      className="inline-flex items-center px-4 py-2 rounded-lg font-mono text-sm bg-[var(--color-bg-primary)] border border-[var(--color-border-secondary)] text-[var(--color-text-accent)] hover:border-[var(--color-border-accent)] transition-colors"
                    >
                      {cmd}
                    </span>
                  ))}
                </div>
                <p className="text-body text-sm mt-4">
                  Each <code className="text-[var(--color-text-accent)]">:team</code> command spawns the full
                  Tech Lead → Executor → Reviewer cycle with domain-specific specialists.
                </p>
              </CardContent>
            </Card>
          </motion.div>

          {/* Flow illustration */}
          <motion.div
            className="mt-8"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.25 }}
          >
            <Terminal
              command={[
                '/cook:team add dark mode toggle',
                '# → Tech Lead decomposes into sub-tasks',
                '# → Executor (frontend-engineer) implements',
                '# → Reviewer challenges: a11y, color tokens, persistence',
                '# → Executor defends: uses prefers-color-scheme + localStorage',
                '# → Reviewer approves → Consensus ✅',
              ]}
              title="Team Execution Flow"
              showCopy={false}
            />
          </motion.div>
        </div>
      </Section>

      {/* ── Why Teams Section (Benefits) ───────────────────────────── */}
      <Section background="primary" spacing="lg">
        <SectionHeader
          title="Why Adversarial Teams?"
        />

        <div className="grid gap-6 md:grid-cols-2 max-w-4xl mx-auto">
          {[
            { icon: '🛡️', title: 'Defense in Depth', description: 'Every implementation is challenged before delivery. Bugs, security issues, and design flaws get caught in debate — not production.' },
            { icon: '💎', title: 'Higher Quality Output', description: 'Debate forces Executors to justify decisions. The result is code that survives scrutiny, not just code that compiles.' },
            { icon: '⚡', title: 'Domain Expertise', description: '17 purpose-built teams mean the right specialists for every domain. A security review uses a security-engineer, not a generalist.' },
            { icon: '📊', title: 'Traceable Decisions', description: 'Every debate round, defense, and arbitration is recorded. Full audit trail from requirement to delivery.' },
          ].map((benefit, index) => (
            <motion.div
              key={benefit.title}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: index * 0.1 }}
            >
              <Card hoverable className="h-full">
                <CardContent>
                  <div className="text-3xl mb-3">{benefit.icon}</div>
                  <h3 className="heading-card mb-2">{benefit.title}</h3>
                  <p className="text-body">{benefit.description}</p>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>
      </Section>

      {/* ── CTA ────────────────────────────────────────────────────── */}
      <Section background="gradient" spacing="lg">
        <div className="text-center">
          <h2 className="heading-section mb-6">Ready to Deploy a Team?</h2>
          <p className="text-body text-lg mb-8 max-w-xl mx-auto">
            Append <code className="text-[var(--color-text-accent)]">:team</code> to any supported command and
            let the Golden Triangle handle quality for you.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Button variant="primary" size="lg" href="/features/specialist-agents">
              Meet the Agents →
            </Button>
            <Button variant="secondary" size="lg" href="/features/commands-workflows">
              View All Commands
            </Button>
          </div>
        </div>
      </Section>
    </main>
  )
}
