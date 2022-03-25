#!/usr/bin/env bash
#
# simple xunit framework

print_exit_code() {
  local test_case
  test_case="$1"
  local expected_exit_code
  expected_exit_code="$2"
  local actual_exit_code
  actual_exit_code="$(cat "${CURRENT_DIR}/${test_case}.exit_code.log")"

  printf "Failed test case: \033[31m%s\033[0m\n" "${test_case}"
  echo "------------"
  printf "Expected exit code: \033[33m%s\033[0m, actual: %s\n" "${expected_exit_code}" "${actual_exit_code}"
}

print_result() {
  local test_case
  test_case="$1"
  local expected_result
  expected_result="$2"
  local actual_result
  actual_result="$(cat "${CURRENT_DIR}/${test_case}.log")"

  printf "Failed test case: \033[31m%s\033[0m\n" "${test_case}"
  echo "------------"
  printf "Expected result: '\033[33m%s\033[0m', but:\n\n%s" "${expected_result}" "${actual_result}"
}

verify_test() {
  local test_case
  test_case="$1"
  local expected_exit_code
  expected_exit_code="$2"
  local expected_result
  expected_result="$3"

  if [[ "$(cat "${CURRENT_DIR}/${test_case}.exit_code.log")" != "${expected_exit_code}" ]]; then
    print_exit_code "${test_case}" "${expected_exit_code}"
    exit 1
  fi

  test_result="$(grep "${expected_result}" <(cat "${CURRENT_DIR}/${test_case}.log"))"
  if [[ "${expected_result}" != "" && "${test_result}" == "" ]]; then
    print_result "${test_case}" "${expected_result}"
    exit 1
  fi
}
