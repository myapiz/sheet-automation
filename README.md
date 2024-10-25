# Automated Publishing and Testing of Spreadsheets with Sheet API

## Introduction

This is minimal example of using Sheet APIs for:

- automatically and instantly publishing spreadsheets as public APIs
- running automated functional tests on spreadsheets using Sheet APIs

For this example, there are no external dependencies except for the Sheet APIs.

## Prerequisites

- [Github account](https://github.com)

- [myAPIz account](https://myapiz.com)

- [Client App with Sheet API installed and configured](https://myapiz.com/apis/sheet)

## Setup

- The spreadsheet to be used for publishing is [mortgage.xlsx](mortgage.xlsx).
  You can add other spreadsheets to the same folder.

- We are going to use Github Actions to publish and test the spreadsheet using
  [Publishing Workflow](.github/workflows/publish.yml) defined in
  the .github/workflows folder.

- Testing is implemented using a simple script as shown below.

- This Github repository needs to be configured with secret
  variable `SHEET_API_KEY` containing API key of a client app
  with "write" and "execute" permissions.

## Github Actions Workflow

### Publishing as an API

The publishing steps are defined in the .github/workflows/publish.yml file
and in .github/workflows/publish.sh script.

It is triggered by a push to the main branch with changed xlsx or test\_\* file.

The workflow downloads this repository and then sends the spreadsheet via POST request
to the Sheet API which creates or overwrites the spreadsheet in your client application
account. SHEET_API_KEY secret variable is used to authenticate the request.

### Running tests

In the tests folder, we have a simple testing setup with helper functions for calling
the newly published spreadsheet and some asserting functions -- tests/sheet.sh
and tests/assert.sh.

The test scripts are defined in tests/test\_\*.sh files.

The example test_mortgage.sh script defines a test scenario for the spreadsheet
and then executes it.

Here is an example of a test scenario:

```bash

  # calculate total interest with load amount 300000 and interest rate 2.0
  assert_contain "$(eval_sheet "mortgage.xlsx" I13 E8=300000 E9=2.0)" "1721296." "total interest is invalid"
```

Here we evaluate the spreadsheet with two input parameters "E8=300000 E9=2.0" and
we assert that the output cell "I13" contains "1721296.".

To simplify testing, the eval_sheet function takes the reference of
the single cell that we are validating.
