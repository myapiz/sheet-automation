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
  variable `SHEET_API_KEY` containing "write" capable API key.

## Publishing Workflow

The publishing workflow is defined in the .github/workflows/publish.yml file.

It is triggered by a push to the main branch and on changed xlsx file.

The workflow downloads this repository and then sends the spreadsheet via POST request
to the Sheet API which creates or overwrites the spreadsheet in your client application
account. SHEET_API_KEY secret variable is used to authenticate the request.
