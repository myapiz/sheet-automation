DIR_TESTS=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source "$DIR_TESTS/assert.sh"

log_header "Test assert : test_assert.sh"

# eval_sheet <sheet_id> <output> [<inputfield=value>]*
eval_sheet() {
  local id=$1
  local output=$2
  reply=$(curl -s -f -H "x-myapiz-key: $SHEET_API_KEY" "https://api.myapiz.com/sheet/$id/eval?output=$output")
  key=$(jq '.outputs | keys[] | select(contains("!'"$output"'"))' <<<"$reply")
  jq '.outputs['"$key"']' <<<"$reply"
}

test_total_interest() {
  log_header "Test :: total_interest"

  assert_contain "$(eval_sheet "mortgage.xlsx" I13)" "149442." "total interest is invalid"

  log_header "Test :: total_interest end"
}

test_total_interest
