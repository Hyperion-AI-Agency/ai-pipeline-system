# TypeScript Code Patterns

> References: [Clean Code](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882), [refactoring.guru](https://refactoring.guru/)

## Strictness Rules

### Explicit types on every `const`

```ts
// YES
const signals: Signal[] = await signalService.getActive(userId)
const countByDate: Map<string, number> = new Map()

// NO — inferred types are ambiguous for readers
const signals = await signalService.getActive(userId)
```

### Explicit return types on every function

```ts
// YES
async function getActiveSignals(userId: string): Promise<Signal[]> { ... }
function formatOdds(value: number): string { ... }

// NO
async function getActiveSignals(userId: string) { ... }
```

### `satisfies` for return objects

```ts
return {
  total: signals.length,
  active: activeCount,
} satisfies SignalSummary
```

### Named interfaces for complex shapes

```ts
// YES
interface OddsSnapshot {
  bookmaker: string
  odds: number
  timestamp: Date
}
const snapshots: Map<string, OddsSnapshot> = new Map()

// NO — inline types are unreadable
const snapshots: Map<string, { bookmaker: string; odds: number; timestamp: Date }> = new Map()
```

## Naming

### Full names, no abbreviations

| Bad | Good |
|-----|------|
| `sig` | `signal` |
| `evt` | `event` |
| `calc()` | `calculateProfit()` |
| `svc` | `service` |
| `btn` | `button` |

### File naming

| Type | Pattern | Example |
|------|---------|---------|
| Component | PascalCase | `SignalCard.tsx` |
| Hook | kebab-case | `use-signals.ts` |
| Schema | kebab-case | `signal.schema.ts` |
| Service | kebab-case | `scanner.service.ts` |
| Test | kebab-case | `scanner.service.test.ts` |
| Constant | kebab-case | `signal-types.ts` |

### One export per file

Each file exports one component, one schema, one service, or one hook.

## Error Handling

```ts
// API routes
try {
  const result = await service.process(data)
  return NextResponse.json(result)
} catch (error) {
  console.error("[SIGNALS]", error)
  return NextResponse.json({ error: "Processing failed" }, { status: 500 })
}
```

- Never expose internal errors to clients
- Use structured prefixes: `[SIGNALS]`, `[SCANNER]`, `[AUTH]`
- Sentry captures unhandled exceptions automatically

## Testing (TDD)

### Write the test FIRST

```ts
// __tests__/format-odds.test.ts
import { describe, it, expect } from "vitest"
import { formatOdds } from "../format-odds"

describe("formatOdds", () => {
  it("formats decimal odds to 2 places", () => {
    expect(formatOdds(2.5)).toBe("2.50")
  })

  it("returns 'N/A' for zero", () => {
    expect(formatOdds(0)).toBe("N/A")
  })
})
```

Then implement:

```ts
// format-odds.ts
export function formatOdds(value: number): string {
  if (value === 0) return "N/A"
  return value.toFixed(2)
}
```

## Design Patterns

Before adding abstractions, verify at [refactoring.guru/design-patterns](https://refactoring.guru/design-patterns):

| Pattern | When to Use | Reference |
|---------|-------------|-----------|
| Factory | Creating objects without specifying exact class | [refactoring.guru/factory-method](https://refactoring.guru/design-patterns/factory-method) |
| Strategy | Swapping algorithms at runtime (e.g., different bookmaker parsers) | [refactoring.guru/strategy](https://refactoring.guru/design-patterns/strategy) |
| Observer | Event-driven updates (e.g., signal state changes) | [refactoring.guru/observer](https://refactoring.guru/design-patterns/observer) |
| Adapter | Wrapping external APIs to match internal interface | [refactoring.guru/adapter](https://refactoring.guru/design-patterns/adapter) |

**Rule:** If the pattern doesn't have a name on refactoring.guru, you probably don't need the abstraction.

## Refactoring

Before refactoring, identify the code smell at [refactoring.guru/refactoring/smells](https://refactoring.guru/refactoring/smells):

| Smell | Technique | Reference |
|-------|-----------|-----------|
| Long Method | Extract Method | [refactoring.guru/extract-method](https://refactoring.guru/refactoring/techniques/composing-methods/extract-method) |
| Feature Envy | Move Method | [refactoring.guru/move-method](https://refactoring.guru/refactoring/techniques/moving-features-between-objects/move-method) |
| Primitive Obsession | Replace with Object | [refactoring.guru/replace-data-value-with-object](https://refactoring.guru/refactoring/techniques/organizing-data/replace-data-value-with-object) |
| Switch Statements | Replace with Polymorphism | [refactoring.guru/replace-conditional-with-polymorphism](https://refactoring.guru/refactoring/techniques/simplifying-conditional-expressions/replace-conditional-with-polymorphism) |

**Rule:** Name the smell before applying the fix.
