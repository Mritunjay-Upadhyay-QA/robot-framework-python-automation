#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

MODE="${1:-all}"
TARGET_ENV="${2:-qa}"

export ENV="${TARGET_ENV}"
export HEADLESS="${HEADLESS:-true}"

rm -rf results
mkdir -p results

COMMON_ARGS=(
    --pythonpath .
    --outputdir results
)

case "${MODE}" in
    all)
        robot "${COMMON_ARGS[@]}" tests
        ;;
    web)
        robot "${COMMON_ARGS[@]}" tests/web
        ;;
    api)
        robot "${COMMON_ARGS[@]}" tests/api
        ;;
    smoke)
        robot "${COMMON_ARGS[@]}" --include smoke tests
        ;;
    regression)
        robot "${COMMON_ARGS[@]}" --include regression tests
        ;;
    parallel)
        pabot --processes "${PROCESSES:-4}" "${COMMON_ARGS[@]}" tests
        ;;
    *)
        echo "Unknown mode: ${MODE}"
        echo "Use: all, web, api, smoke, regression, or parallel"
        exit 1
        ;;
esac
