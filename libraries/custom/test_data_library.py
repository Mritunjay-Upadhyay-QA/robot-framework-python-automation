"""Custom Robot Framework keywords for dynamic test-data generation."""

from __future__ import annotations

from datetime import date, timedelta
from uuid import uuid4

from robot.api.deco import keyword, library


@library(scope="SUITE")
class TestDataLibrary:
    """Generate reusable dynamic test data for automation scenarios."""

    @keyword("Generate Checkout Customer")
    def generate_checkout_customer(self) -> dict[str, str]:
        """Generate customer information suitable for SauceDemo checkout."""
        unique_suffix = uuid4().hex[:6]

        return {
            "first_name": f"Robot{unique_suffix}",
            "last_name": "Automation",
            "postal_code": "560001",
        }

    @keyword("Generate Unique Email")
    def generate_unique_email(self, prefix: str = "robot") -> str:
        """Generate a unique email address for test automation."""
        unique_suffix = uuid4().hex[:8]

        return f"{prefix}.{unique_suffix}@example.com"

    @keyword("Get Future Date")
    def get_future_date(
        self,
        days: int = 7,
        date_format: str = "%Y-%m-%d",
    ) -> str:
        """Return a future date using the requested output format."""
        future_date = date.today() + timedelta(days=days)

        return future_date.strftime(date_format)