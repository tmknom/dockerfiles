#!/usr/bin/env bash
#
# test markdownlint

TOOL_NAME=markdownlint

CURRENT_DIR="$(
  cd "$(dirname "$0")" || exit 1
  pwd
)"

# shellcheck disable=SC1091
source "${CURRENT_DIR}"/../xunit.sh

run_test() {
  docker run -it --rm -v "$(pwd):/work" -w /work \
    --user 1111:1111 --read-only --security-opt no-new-privileges --cap-drop all \
    ghcr.io/tmknom/dockerfiles/"${TOOL_NAME}":latest \
    ".github/tests/${TOOL_NAME}/${test_case}_md.txt" \
    >"${CURRENT_DIR}/${test_case}.log" 2>&1

  echo "$?" >"${CURRENT_DIR}/${test_case}.exit_code.log"
}

run() {
  local test_case
  test_case="$1"
  local expected_exit_code
  expected_exit_code="$2"
  local expected_result
  expected_result="$3"

  run_test "${test_case}"
  verify_test "${test_case}" "${expected_exit_code}" "${expected_result}"
}

# test
run "valid" "0" ""
run "invalid" "1" "Files should end with a single newline character"

rm "${CURRENT_DIR}"/*.log
echo "Success all test!"
