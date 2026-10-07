"""Custom validation keywords for API automation."""

from __future__ import annotations

from typing import Any

from jsonschema import validate
from robot.api.deco import keyword, library


BOOKING_SCHEMA = {
    "type": "object",
    "required": [
        "firstname",
        "lastname",
        "totalprice",
        "depositpaid",
        "bookingdates",
        "additionalneeds",
    ],
    "properties": {
        "firstname": {"type": "string"},
        "lastname": {"type": "string"},
        "totalprice": {"type": "integer"},
        "depositpaid": {"type": "boolean"},
        "bookingdates": {
            "type": "object",
            "required": ["checkin", "checkout"],
            "properties": {
                "checkin": {"type": "string"},
                "checkout": {"type": "string"},
            },
        },
        "additionalneeds": {"type": "string"},
    },
}


@library(scope="GLOBAL")
class ApiValidationLibrary:
    """Provide reusable API response validation keywords."""

    @keyword("Validate Booking Schema")
    def validate_booking_schema(self, payload: dict[str, object]) -> None:
        """Validate a booking response against the expected JSON schema."""
        validate(instance=payload, schema=BOOKING_SCHEMA)

    @keyword("Response Time Should Be Below")
    def response_time_should_be_below(
        self,
        response: Any,
        max_milliseconds: float = 5000,
    ) -> None:
        """Assert that an HTTP response completed within the threshold."""
        actual_milliseconds = response.elapsed.total_seconds() * 1000

        if actual_milliseconds >= max_milliseconds:
            raise AssertionError(
                f"Expected response time below {max_milliseconds:.0f} ms, "
                f"but received {actual_milliseconds:.2f} ms."
            )
