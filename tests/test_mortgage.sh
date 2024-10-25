#!/usr/bin/env bash

DIR_TESTS=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source "$DIR_TESTS/assert.sh"

log_header "Test assert : test_assert.sh"
join_by() {
  local IFS="$1"
  shift
  echo "$*"
}

# eval_sheet <sheet_id> <output> [<inputfield=value>]*
eval_sheet() {
  local id=$1
  local output=$2
  local inputs=("${@:3}")
  input_query=$(join_by "&" "${inputs[@]}")
  reply=$(curl -s -f -H "x-myapiz-key: $SHEET_API_KEY" "https://api.myapiz.com/sheet/$id/eval?output=$output&${input_query}")
  key=$(jq '.outputs | keys[] | select(contains("!'"$output"'"))' <<<"$reply")
  jq '.outputs['"$key"']' <<<"$reply"
}

test_total_interest() {
  log_header "Test :: total_interest"

  assert_contain "$(eval_sheet "mortgage.xlsx" I13 E8=300000)" "149442." "total interest is invalid"

  log_header "Test :: total_interest end"
}

test_total_interest
