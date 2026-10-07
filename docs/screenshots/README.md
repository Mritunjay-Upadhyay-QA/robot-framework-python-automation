# Report Screenshots

Place screenshots from real Robot Framework executions in this directory when preparing the
portfolio for presentation.

Suggested files:

- `robot-report.png`
- `robot-log.png`

Generate a real run first:

```bash
ENV=qa HEADLESS=true ./scripts/run_tests.sh all qa
open results/report.html
open results/log.html
```

The repository intentionally does not include fabricated report screenshots.
