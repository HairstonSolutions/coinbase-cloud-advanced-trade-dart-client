# AGENTS.md

The project is a Dart client for the Coinbase Advanced Trade API.

## Do

- When adding new features with REST functionality, create mocks for tests based off of the Coinbase documentation, also
  add skippable tests against the actual Coinbase API Endpoints.
- Follow the structure of existing functions and endpoints.
- Check that API documentation links are accurate and work.

## Don't

- do not add new heavy dependencies without approval

## Commands

### tests

- Tests can be run using the command `dart test --reporter=expanded`.
- Specific test files can be targeted by appending the file path.

## Mocking

- The project uses the mockito package for mocking in tests.
- The project uses build_runner to generate mock files. The command dart run build_runner build must be run before
  executing tests that use mocks.

## Safety and permissions

Allowed without prompt:

- read files, list files

Ask first:

- package installs,
- git push
- deleting files, chmod

## Project structure

- Rest Endpoints are in lib/src/rest

## PR checklist

- dart format check: green
- unit tests: green. add tests for new code paths
- diff: small with a brief summary

## When stuck

- ask a clarifying question, propose a short plan, or open a draft PR with notes

## Test first mode

- write or update tests first on new features, then code to green

## Other

- The project has a feature-based structure. REST API clients are located in lib/src/rest/ and data models are in
  lib/src/models/.
- The lib/src/services/network.dart file contains helper functions like getAuthorized, postAuthorized, putAuthorized,
  and deleteAuthorized for making authenticated API requests.
- The Credential class in lib/src/models/credential.dart requires apiKeyName and a valid privateKeyPEM string for its
  constructor.
- The getAuthorized function in lib/src/services/network.dart accepts an optional http.Client to allow for mocking
  network requests in tests.
