# Contributing

## Development Setup

```bash
python3.12 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
rfbrowser install chromium
pre-commit install
```

## Branch Naming

Use descriptive branch names such as:

```text
feat/add-booking-filter-tests
fix/checkout-locator
refactor/api-keywords
ci/update-regression-workflow
docs/update-readme
```

## Commit Messages

Use conventional commit style:

```text
feat: add booking CRUD automation
test: add negative booking scenarios
fix: correct checkout locator
refactor: extract reusable API keywords
ci: add parallel regression workflow
docs: update execution instructions
```

## Before Opening a Pull Request

Run:

```bash
./scripts/run_quality.sh
pre-commit run --all-files
ENV=qa HEADLESS=true ./scripts/run_tests.sh all qa
PROCESSES=4 ENV=qa HEADLESS=true ./scripts/run_tests.sh parallel qa
```

All checks should pass before merge.

## Pull Requests

A pull request should explain:

- What changed
- Why the change was required
- Which tests were added or changed
- How the change was validated
- Any known limitations

Generated Robot Framework results must not be committed.
