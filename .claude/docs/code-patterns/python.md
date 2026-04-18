# Python Code Patterns

> References: [Clean Code](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882), [refactoring.guru](https://refactoring.guru/)

## Type Annotations

### Always annotate function signatures

```python
# YES
async def get_active_signals(user_id: str) -> list[Signal]:
    ...

def calculate_profit(stake: float, odds: float) -> float:
    ...

# NO
async def get_active_signals(user_id):
    ...
```

### Annotate variables when the type isn't obvious

```python
# YES — type not obvious from right side
signals: list[Signal] = await service.get_active(user_id)
count_by_date: dict[str, int] = {}

# OK — type is obvious
name = "MatchedPro"
count = 0
```

## Naming

### snake_case for everything except classes

```python
# Functions, variables, modules
def calculate_expected_value(odds: float, probability: float) -> float:
    ...

signal_count: int = len(active_signals)

# Classes
class SignalService:
    ...

class BetfairClient:
    ...
```

### Full names, no abbreviations

| Bad | Good |
|-----|------|
| `calc_ev()` | `calculate_expected_value()` |
| `sig` | `signal` |
| `db` | `database` or `session` |
| `mgr` | `manager` |

## Service Pattern

```python
# api/signals/service.py
from api.signals.crud import SignalCRUD
from api.signals.schemas import SignalCreate, SignalResponse

class SignalService:
    def __init__(self, crud: SignalCRUD | None = None):
        self.crud = crud or SignalCRUD()

    async def create(self, data: SignalCreate, user_id: str) -> SignalResponse:
        signal = await self.crud.create(data, user_id)
        return SignalResponse.model_validate(signal)

    async def get_active(self, user_id: str) -> list[SignalResponse]:
        signals = await self.crud.find_active(user_id)
        return [SignalResponse.model_validate(s) for s in signals]
```

Key rules:
- Constructor takes optional deps for testing
- Business logic in service, not in routes or CRUD
- Return Pydantic models, not raw DB rows

## CRUD Pattern

```python
# api/signals/crud.py
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from api.signals.models import Signal

class SignalCRUD:
    def __init__(self, session: AsyncSession | None = None):
        self.session = session

    async def find_active(self, user_id: str) -> list[Signal]:
        result = await self.session.execute(
            select(Signal).where(Signal.user_id == user_id, Signal.status == "active")
        )
        return list(result.scalars().all())
```

## Testing (TDD)

### Write the test FIRST

```python
# __tests__/test_profit.py
import pytest
from api.signals.service import calculate_profit

def test_profit_positive():
    assert calculate_profit(stake=10.0, odds=2.5) == 15.0

def test_profit_loss():
    assert calculate_profit(stake=10.0, odds=0.0) == -10.0

def test_profit_zero_stake():
    assert calculate_profit(stake=0.0, odds=2.5) == 0.0
```

Then implement:

```python
def calculate_profit(stake: float, odds: float) -> float:
    if stake == 0:
        return 0.0
    return (stake * odds) - stake
```

### Mock services, not databases

```python
# __tests__/test_signal_service.py
from unittest.mock import AsyncMock
from api.signals.service import SignalService

async def test_create_signal():
    mock_crud = AsyncMock()
    mock_crud.create.return_value = Signal(id="1", event_name="Test", status="active")

    service = SignalService(crud=mock_crud)
    result = await service.create(SignalCreate(event_name="Test", bookmaker="bet365", odds=2.5), "user1")

    assert result.status == "active"
    mock_crud.create.assert_called_once()
```

## Error Handling

```python
# In routes — raise HTTPException
from fastapi import HTTPException

@router.get("/signals/{signal_id}")
async def get_signal(signal_id: str):
    signal = await crud.find_by_id(signal_id)
    if not signal:
        raise HTTPException(status_code=404, detail="Signal not found")
    return signal

# In services — raise domain exceptions, let routes handle them
class SignalNotFoundError(Exception):
    pass
```

## Design Patterns

| Pattern | When to Use | Reference |
|---------|-------------|-----------|
| Strategy | Different parsers per bookmaker | [refactoring.guru/strategy](https://refactoring.guru/design-patterns/strategy) |
| Factory | Creating platform-specific clients | [refactoring.guru/factory-method](https://refactoring.guru/design-patterns/factory-method) |
| Template Method | Shared pipeline steps with platform-specific overrides | [refactoring.guru/template-method](https://refactoring.guru/design-patterns/template-method) |
| Adapter | Wrapping external APIs (Betfair, Odds API) | [refactoring.guru/adapter](https://refactoring.guru/design-patterns/adapter) |
