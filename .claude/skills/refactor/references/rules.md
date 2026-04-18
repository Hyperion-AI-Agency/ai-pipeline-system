# Refactoring Rules

> Concrete, enforceable rules for code quality. Each rule has an ID, scope, and fix guidance.

---

## Frontend Rules

### F-01: Import Order

Imports must follow this order, separated by blank lines:

1. React / third-party (`react`, `@tanstack/*`, `lucide-react`, etc.)
2. Generated API client (`@packages/api-client`)
3. UI primitives (`@packages/ui/components/shadcn/*`)
4. App components (`@/components/*`)
5. App hooks (`@/hooks/*`)
6. App utilities (`@/lib/*`)

**Fix:** Reorder imports. Separate groups with blank lines. Combine `type` imports with their value imports from the same module.

### F-02: No Unused Imports

Every import must be referenced in the file.

**Fix:** Remove unused imports.

### F-03: Named Exports Only

Components must use named exports, never `export default`.

**Fix:** Change `export default function Foo()` to `export function Foo()`.

### F-04: Consistent Component Structure

Each component file should follow:

1. Imports
2. Types/interfaces (if not inline)
3. Constants
4. Exported component function
5. Internal helper components (if any)

**Fix:** Reorder declarations to match structure.

### F-05: Theme Token Usage

Never use raw color values (`#fff`, `rgb(...)`, `oklch(...)`) in component code. Use Tailwind theme tokens:

- Text: `text-text-primary`, `text-text-secondary`, `text-text-muted`
- Backgrounds: `bg-card-bg`, `bg-content-bg`
- Borders: `border-border`
- Status: `text-status-success`, `bg-status-error-light`, etc.
- Brand: `bg-brand`, `text-brand`

**Exception:** `global.css` `@layer base` definitions.

**Fix:** Replace raw values with theme token classes.

### F-06: No Inline Styles

Never use `style={{}}` except for runtime-computed values (progress bars, dynamic widths).

**Fix:** Replace with Tailwind classes. Use `style={{ aspectRatio }}` only for values that can't be expressed in Tailwind.

### F-07: Consistent Card Pattern

Cards must use: `rounded-xl border border-border bg-card-bg p-5` (or use `SectionCard` component).

**Fix:** Replace ad-hoc card styling with `SectionCard` or the standard card classes.

### F-08: Icon Source

All icons must come from `lucide-react`. No custom SVGs, no other icon libraries.

**Fix:** Replace with equivalent lucide-react icon.

### F-09: API Calls via Orval Only

Never use raw `fetch()` or `axios` for API calls. Always use Orval-generated hooks.

**Fix:** Replace with appropriate Orval hook.

### F-10: Mutation Pattern

Mutations must invalidate relevant query caches and show toast feedback:

```tsx
const mutation = useXxxMutation({
  mutation: {
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: getXxxQueryKey() });
      toast.success("Done");
    },
    onError: () => toast.error("Failed"),
  },
});
```

**Fix:** Add missing cache invalidation or toast feedback.

### F-11: Loading & Empty States

Every data-fetching page must have:
- Loading skeleton while fetching
- Empty state when no data

**Fix:** Add missing `Skeleton` or `EmptyState`.

### F-12: Consistent Section Headers

Section headers outside card containers must use:
```tsx
<p className="mb-2 text-sm font-medium text-text-primary">Title</p>
```

Section headers inside cards use `SectionCard title="..."` prop.

**Fix:** Normalize header patterns.

### F-13: Delete Confirmation

All destructive actions must show a confirmation dialog before executing.

**Fix:** Wrap with `ConfirmDeleteDialog`.

### F-14: Button Disabled States

Action buttons that depend on data state must be `disabled` when the prerequisite isn't met (e.g., Download disabled when video not completed).

**Fix:** Add `disabled` prop with appropriate condition.

### F-15: No console.log in Production Code

Remove all `console.log`, `console.warn`, `console.error` from production code. Use `toast` for user-facing messages.

**Fix:** Remove or replace with toast/proper error handling.

---

## Backend Rules

### B-01: Type Hints Everywhere

All function parameters and return types must have type hints.

**Fix:** Add missing type hints.

### B-02: Async Consistency

All database operations and endpoint handlers must be `async`.

**Fix:** Convert sync functions to async.

### B-03: Pydantic Schemas for All Responses

Never return raw dicts from endpoints. Always use `response_model=SchemaClass`.

**Fix:** Create or use appropriate Pydantic schema.

### B-04: Enum Usage for Status Fields

Never use string literals for status comparisons. Use enum members.

```python
# Bad:  Video.status == "completed"
# Good: Video.status == VideoStatus.completed
```

**Fix:** Replace string literals with enum references.

### B-05: Dependency Injection Pattern

CRUD classes must use typed deps:

```python
MyCrudDep = Annotated[MyCrud, Depends()]
```

Endpoints receive deps as parameters, never instantiate manually.

**Fix:** Create typed dep aliases and inject properly.

### B-06: Route Ordering

Static paths must be defined BEFORE parameterized paths to avoid FastAPI routing conflicts.

```python
# Good:
@router.get("/stats/dashboard")  # static first
@router.get("/{video_id}")       # param second
```

**Fix:** Reorder route definitions.

### B-07: Module Structure

Every domain module must follow:

```
module_name/
├── __init__.py
├── enums.py
├── routes.py
├── models/
│   ├── __init__.py
│   └── model_name.py
├── schemas.py
└── crud.py
```

**Fix:** Reorganize files into standard structure.

### B-08: No Hardcoded Secrets

Never hardcode API keys, passwords, or secrets. Use `settings.py` (Pydantic BaseSettings with `API_` prefix).

**Fix:** Move to environment variable via settings.

### B-09: Migration Defaults

When adding NOT NULL columns to existing tables, always include `server_default` in the migration.

**Fix:** Add `server_default` to migration `op.add_column()`.

### B-10: Schema Field Naming

Schema field names must match the model column names exactly. Computed fields must be clearly distinguished (e.g., `avg_*` prefix).

**Fix:** Align field names.

---

## Shared Rules

### S-01: No Dead Code

Remove commented-out code, unused functions, unused variables, and `{false && <Component />}` blocks.

**Fix:** Delete dead code.

### S-02: Consistent Naming

- Frontend: camelCase for variables/functions, PascalCase for components, kebab-case for files
- Backend: snake_case for everything, PascalCase for classes

**Fix:** Rename to match convention.

### S-03: No TODO Without Context

TODOs must include what needs to be done. Bare `// TODO` or `# TODO` are not allowed.

**Fix:** Add description or remove if no longer applicable.

### S-04: UI Label Consistency

Use consistent terminology across the entire UI:

| Internal Field | UI Label |
|---------------|----------|
| `generation_time_ms` | "Video Length" |
| `tokens_used` | "Tokens" |
| `total_cost_usd` | "Total Cost" or "Cost" |
| `avg_cost_per_shot_usd` | "Avg Cost / Shot" or "Cost" (in per-shot context) |
| `file_size_bytes` | "File Size" |
| `current_stage` | Pipeline stage names (Queued, Audio, etc.) |
| `created_at` | "Created" |

**Fix:** Replace mismatched labels.
