"""Robot Framework variable file for runtime configuration."""

from __future__ import annotations

import os

try:
    from .environments import ENVIRONMENTS
except ImportError:
    from environments import ENVIRONMENTS


def _to_boolean(value: str) -> bool:
    """Convert an environment variable value to a boolean."""
    return value.strip().lower() in {"1", "true", "yes", "on"}


def get_variables() -> dict[str, object]:
    """Return runtime variables used by Robot Framework."""

    selected_environment = os.getenv("ENV", "qa").lower()

    if selected_environment not in ENVIRONMENTS:
        supported_environments = ", ".join(ENVIRONMENTS)

        raise ValueError(
            f"Unsupported environment '{selected_environment}'. "
            f"Supported environments: {supported_environments}"
        )

    environment = ENVIRONMENTS[selected_environment]

    return {
        "ENV": selected_environment,
        "BASE_URL": os.getenv("WEB_BASE_URL", environment["web_url"]),
        "API_BASE_URL": os.getenv("API_BASE_URL", environment["api_url"]),
        "BROWSER": os.getenv("BROWSER", "chromium"),
        "HEADLESS": _to_boolean(os.getenv("HEADLESS", "false")),
    }