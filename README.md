# Robot Framework Python Automation

A portfolio grade automation framework built with Robot Framework and Python.

The repository demonstrates web UI automation, REST API automation, reusable keyword design,
custom Python libraries, runtime configuration, parallel execution, code quality controls,
CI/CD, Docker, reporting, and a professional Git workflow.

## Systems Under Test

The framework uses public practice systems only:

- SauceDemo for web UI automation
- Restful Booker for REST API automation

## Features

- Browser automation using Robot Framework Browser Library and Playwright
- REST API automation using RequestsLibrary
- Positive and negative scenarios
- End to end checkout coverage
- Full booking CRUD lifecycle
- JSON schema validation
- Response time validation
- Dynamic Python generated test data
- Environment based runtime configuration
- Runtime credential handling
- Smoke, regression, web, API, positive, negative, and E2E tags
- Parallel execution using Pabot
- Python linting and formatting using Ruff
- Robot Framework linting using Robocop
- Pre commit quality gates
- GitHub Actions CI/CD
- Docker execution
- Robot Framework HTML reports

## Technology Stack

- Python 3.12+
- Robot Framework 7.5
- Robot Framework Browser Library 20.6
- Playwright
- RequestsLibrary
- Pabot
- Ruff
- Robocop
- pre-commit
- JSON Schema
- GitHub Actions
- Docker

## Architecture

```text
Tests
  |
  +-- Web tests
  |     |
  |     +-- Business keywords
  |            |
  |            +-- Page resources
  |                   |
  |                   +-- Browser Library / Playwright
  |
  +-- API tests
        |
        +-- API resources
               |
               +-- RequestsLibrary

Shared infrastructure
  |
  +-- Python configuration
  +-- Custom Python libraries
  +-- Dynamic test data
  +-- Environment variables
  +-- Reporting
  +-- Parallel execution
```

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for architectural decisions.

## Folder Structure

```text
robot-framework-python-automation/
|
+-- config/
+-- libraries/
|   +-- custom/
+-- resources/
|   +-- api/
|   +-- common/
|   +-- keywords/
|   +-- pages/
|   +-- variables/
+-- tests/
|   +-- api/
|   +-- web/
+-- scripts/
+-- docs/
+-- .github/
|   +-- workflows/
+-- .env.example
+-- .gitignore
+-- .pre-commit-config.yaml
+-- Dockerfile
+-- pyproject.toml
+-- robot.toml
+-- requirements.txt
+-- CONTRIBUTING.md
+-- LICENSE
+-- README.md
```

## Prerequisites

- Python 3.12 or newer
- Git
- Docker for container execution
- Visual Studio Code with RobotCode is recommended

## Local Setup

Create and activate a virtual environment:

```bash
python3.12 -m venv .venv
source .venv/bin/activate
```

Install project dependencies:

```bash
python -m pip install -r requirements.txt
```

Install Chromium:

```bash
rfbrowser install chromium
```

Enable pre commit hooks:

```bash
pre-commit install
```

## Environment Configuration

The framework uses environment variables for runtime configuration.

```bash
export ENV=qa
export BROWSER=chromium
export HEADLESS=true
export API_USERNAME=admin
export API_PASSWORD=password123
```

The API credentials above are public Restful Booker training credentials. For real systems,
use private environment variables or GitHub Actions Secrets.

See `.env.example` for all supported values.

## Running Tests

All tests:

```bash
./scripts/run_tests.sh all qa
```

Web:

```bash
./scripts/run_tests.sh web qa
```

API:

```bash
./scripts/run_tests.sh api qa
```

Smoke:

```bash
./scripts/run_tests.sh smoke qa
```

Regression:

```bash
./scripts/run_tests.sh regression qa
```

Parallel:

```bash
PROCESSES=4 ./scripts/run_tests.sh parallel qa
```

Run directly by tag:

```bash
robot --pythonpath . --outputdir results --include negative tests
```

Run using a browser override:

```bash
BROWSER=chromium ./scripts/run_tests.sh web qa
```

## Test Coverage

### Web

- Valid login
- Invalid login
- Locked user
- Product inventory
- Product sorting
- Add and remove cart items
- Cart navigation
- Checkout field validation
- Successful end to end purchase

### API

- Authentication
- Retrieve booking IDs
- Create booking
- Retrieve booking by ID
- Full update using PUT
- Partial update using PATCH
- Delete booking
- Verify deletion
- Data driven missing booking scenarios
- JSON schema validation
- Response time validation

## Reports

Robot Framework writes generated files under `results/`:

- `results/report.html`
- `results/log.html`
- `results/output.xml`

Open the report on macOS:

```bash
open results/report.html
```

GitHub Actions also uploads these reports as workflow artifacts, including when a test fails.

Real report screenshots should be captured from an actual run rather than fabricated. The
expected location for portfolio screenshots is `docs/screenshots/`.

## Code Quality

Run all configured quality checks:

```bash
./scripts/run_quality.sh
```

Python formatting and linting:

```bash
ruff format .
ruff check .
```

Robot Framework linting:

```bash
robocop check --threshold E .
```

Robot Framework formatting is available through:

```bash
robocop format .
```

Run pre commit hooks manually:

```bash
pre-commit run --all-files
```

## CI/CD

`.github/workflows/ci.yml` runs on pull requests, pushes to main, and manual dispatch.

It performs:

1. Code quality checks
2. Headless smoke execution
3. Robot Framework artifact upload

`.github/workflows/regression.yml` provides scheduled and manual parallel regression.

The public Restful Booker demo credentials are used as CI fallbacks. If repository secrets
`BOOKER_USERNAME` and `BOOKER_PASSWORD` are configured, the workflows use those instead.

## Docker

Build:

```bash
docker build -t robot-framework-python-automation .
```

Run:

```bash
docker run --rm \
  --ipc=host \
  -e API_USERNAME=admin \
  -e API_PASSWORD=password123 \
  robot-framework-python-automation
```

The Docker image is based on the version matched Robot Framework Browser image.

## Security

- `.env` is ignored by Git
- Real credentials should never be committed
- Runtime configuration is supplied through environment variables
- GitHub Actions can use repository secrets
- Generated reports and virtual environments are ignored

## Known Limitations

- SauceDemo exposes one public deployment, so dev, QA, and staging currently target the same URL
- Restful Booker is a public practice service and can reset data or become temporarily unavailable
- Chromium is the default local browser
- Public demo systems can fail independently of framework code

## Future Improvements

- Cross browser CI matrix
- Accessibility automation
- Performance testing integration
- Additional API schema coverage
- Automated release notes
- Test analytics dashboard

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT. See [LICENSE](LICENSE).
