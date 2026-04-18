---
name: refactor
description: Audit and refactor code for consistency, conventions compliance, and quality. Use when asked to refactor, clean up, audit code quality, or enforce coding standards across the codebase.
---

# Refactor

Audit and refactor code across the Lead Alliances video pipeline for consistency, conventions compliance, and maintainability.

## When to Use

- User asks to "refactor", "clean up", "audit", or "enforce conventions"
- After a large feature implementation to normalize patterns
- When code drift is suspected across modules

## Process

### Phase 1: Load Rules

Read the refactoring rules from `.claude/skills/refactor/references/rules.md` and the project conventions from `apps/mkdocs/docs/reference/coding-conventions.md`.

### Phase 2: Scan

For each target (frontend, backend, or both):

1. **List all files** in the target directories
2. **Read each file** and check against the rules
3. **Collect violations** with file path, line number, rule ID, and description

### Phase 3: Fix

For each violation:

1. Apply the fix following the rule's guidance
2. Ensure the fix doesn't break types or functionality
3. Group related fixes per file to minimize edits

### Phase 4: Verify

1. Run `npx tsc --noEmit` for frontend changes
2. Run `pnpm lint` if available
3. Regenerate API client if backend schemas changed: `pnpm run generate-api`

### Phase 5: Report

Output a summary table:

```
| File | Rule | Change |
|------|------|--------|
| path/to/file.tsx | F-01 | Fixed import order |
```

## Scope Control

- **`/refactor frontend`** — Only `apps/react/src/`
- **`/refactor backend`** — Only `apps/api/api/`
- **`/refactor all`** — Both frontend and backend
- **`/refactor <path>`** — Specific file or directory
