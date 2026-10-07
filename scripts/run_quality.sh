#!/usr/bin/env bash

set -euo pipefail

ruff format --check .
ruff check .
robocop check --threshold E .
