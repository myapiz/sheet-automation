#!/usr/bin/env bash
set -e

# import assert and sheet helper functions
DIR_TESTS=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR_TESTS/assert.sh"
source "$DIR_TESTS/sheet.sh"

log_header "Test assert : test_assert.sh"

test_total_interest() {
  log_header "Test :: total_interest"

  # calculate total interest with load amount 300000 and interest rate 2.0
  assert_contain "$(eval_sheet "mortgage.xlsx" I13 E8=300000 E9=2.0)" "1721296." "total interest is invalid"

}

test_total_interest
