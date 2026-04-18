# Write SOP

Write a new Standard Operating Procedure document for the Lead Alliances Video Pipeline project.

## Variables

topic: $ARGUMENTS (topic or area to document, e.g. `testing unit tests` or `error handling patterns`)

---

## Instructions

**You are writing a REFERENCE DOCUMENT, not implementing code.** Research the codebase and best practices, then produce an SOP that is copy-paste ready and tech-stack specific.

---

## Phase 1: Research

1. **Scan the codebase** for existing patterns related to the topic:
   - Search for implementations, utilities, and conventions already in use
   - Read at least 3-5 representative files to understand current practices
   - Note any inconsistencies or anti-patterns
2. **Read existing SOPs** in `.claude/docs/sops/` to understand the format and depth:
   - `.claude/docs/sops/backend-sop.md`
   - `.claude/docs/sops/frontend-sop.md`
   - `.claude/docs/sops/claude-agent-sop.md`
   - Pick the one closest to the topic for format reference
3. **Read architecture docs** in `.claude/docs/` for relevant context
4. **Identify the tech stack** involved:
   - Backend: Python, FastAPI, SQLAlchemy, Celery, Pydantic
   - Frontend: React, TypeScript, TanStack Router/Query, Tailwind, shadcn/ui
   - Testing: pytest, Vitest, Playwright
   - Infra: Docker, pnpm monorepo, Alembic

---

## Phase 2: Outline

1. **Define the scope** — what does this SOP cover and what is out of scope?
2. **List the sections** — each section should cover one cohesive pattern or process
3. **For each section, identify:**
   - The pattern or rule
   - A concrete code example from this project (or a realistic one matching the stack)
   - Common mistakes to avoid
4. **Plan the structure:**
   - Start with the most commonly needed patterns
   - Group related patterns together
   - End with a quick-reference cheat sheet or decision tree

---

## Phase 3: Write the SOP

Save to `.claude/docs/sops/{topic-slug}-sop.md`

### SOP Format Requirements

- **Title:** `# {Topic} SOP`
- **Sections numbered:** `## 1. Section Title` with subsections `### 1.1 Subsection`
- **Every rule must have a code example** — use actual project paths and patterns
- **Code examples must be copy-paste ready** — correct imports, correct types, correct file locations
- **Include "DO" and "DON'T" examples** for critical patterns
- **Anti-patterns section** — list common mistakes with explanations
- **Quick reference** at the bottom — a cheat sheet, decision tree, or checklist

### Tone and Style

- Imperative, direct language ("Use X", "Never do Y")
- No fluff — every sentence should be actionable
- Tech-stack specific — reference actual libraries, not generic concepts
- Assume the reader is an AI agent or developer who needs exact instructions

---

## Phase 4: Update CLAUDE.md

1. **Read** `.claude/CLAUDE.md`
2. **Add the new SOP** to the SOPs table in CLAUDE.md:
   - Add a row to the SOP table with the name, link, and "Read when..." description
3. **Add to the "When to read which SOP"** section if the new SOP fits into common workflows

---

## Phase 5: Report

```
## SOP Created

### Document
- `.claude/docs/sops/{topic-slug}-sop.md`

### Sections
1. [Section 1 title]
2. [Section 2 title]
...

### CLAUDE.md Updated
- Added to SOPs table
- Added to "When to read which SOP" section

### Notes
- [Any cavebase patterns that were inconsistent and need cleanup]
- [Any areas that need deeper investigation]
```
