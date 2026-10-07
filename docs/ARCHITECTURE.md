# Architecture

## Purpose

This repository keeps web and API automation in one framework while separating responsibilities
so test cases remain readable and implementation details remain reusable.

## Layers

### Tests

Files under `tests/` describe expected behaviour and contain assertions relevant to scenarios.

Web and API tests are separated by domain, but both use the same configuration, reporting,
quality, and CI infrastructure.

### Page Resources

Files under `resources/pages/` own web locators and page specific behaviour.

Tests do not need to know how SauceDemo elements are located.

### Business Keywords

Files under `resources/keywords/` represent reusable user flows that cross individual page
actions, such as opening the Products page as an authenticated user.

### API Resources

Files under `resources/api/` own HTTP request construction and authentication flows.

Tests receive response objects and perform scenario specific validation.

### Python Libraries

Files under `libraries/custom/` are used when Python expresses logic more clearly than Robot
Framework syntax. Current examples include dynamic test data, JSON schema validation, and
response time validation.

### Configuration

`config/environment.py` exposes runtime values to Robot Framework. URLs, browser selection,
headless mode, and API credentials are supplied through environment variables.

Page and API resources consume configuration without hardcoding environment specific values.

## Test Independence

Each web test opens and closes its own browser session.

API tests create their own mutable data and clean it up when appropriate.

This makes suite level parallel execution with Pabot practical and avoids depending on
execution order.

## Locator Strategy

The framework prefers application provided `data-test` attributes for SauceDemo because they
are intended for automation and are less coupled to layout or styling than long XPath expressions.

## Secrets

Real credentials are never stored in test resources.

Local runs use environment variables. GitHub Actions can use repository secrets.

The Restful Booker credentials referenced in documentation are public training credentials only.

## Reporting

Robot Framework creates `output.xml`, `log.html`, and `report.html` under `results/`.

CI uploads the same folder as an artifact even when execution fails.

## Parallel Execution

Pabot runs independent suites concurrently. Shared mutable accounts or backend data would require
resource locks or isolated datasets in a real system. This practice framework avoids shared mutable
state for its current scenarios.

## CI Strategy

Pull requests run quality checks and smoke coverage.

The regression workflow supports manual execution and weekday scheduled execution using Pabot.

## Docker Strategy

The project extends the Robot Framework Browser image pinned to Browser Library 20.6.0.
This reduces mismatches between Browser Library, Playwright, browser binaries, and system libraries.
