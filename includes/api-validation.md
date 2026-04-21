# API Response Validation

NEVER silently accept unexpected empty or null responses. Treat them as suspicious.

## Protocol

1. STOP — do not proceed with empty data
2. Try a minimal/simplified query to isolate the issue
3. Ask the user to confirm against their UI
4. Document the quirk in `~/.claude/learnings/`

## Indicators of a Bad Empty

- User says data exists but API returns 0/empty/null
- A complex query fails but a simpler one works
- Adding filters unexpectedly breaks results

## Fallback Pattern

```python
r = api_call(complex_params)
if not r and context_suggests_data:
    s = api_call(minimal_params)
    if s:
        warn_user("Complex query returned 0, using simplified")
    else:
        ask_user("API shows 0 — does this match your UI?")
```

## When Data Is Actually Missing

```
"The [tool] shows no [data] for the period.
Possible reasons: (1) most likely, (2) alternative, (3) unlikely.
Next: [actionable step]."
```

## Documentation

Record quirks with: symptom, workaround, date, failing vs working example.

**Golden rule**: when in doubt about data quality → ASK THE USER.
