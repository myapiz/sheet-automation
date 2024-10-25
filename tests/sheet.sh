#!/usr/bin/env bash

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
