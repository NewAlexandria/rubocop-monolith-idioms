# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### New cops

- (none yet)

### Changes

- (none yet)

## [0.1.0] - YYYY-MM-DD

### Added

- **Naming/MethodNameGetPrefix** - Flags methods with `get_` or `set_` prefixes that take arguments, suggesting idiomatic Ruby naming conventions.
- Plugin-based loading (RuboCop 1.72+).
- Legacy `require` loading for older RuboCop versions.
- Cop documentation in `guides/`.
- Rake task `new_cop[Department/CopName]` for scaffolding new cops.
- Contributing guide: `docs/ADDING_COPS.md`.
