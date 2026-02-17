# rubocop-monolith-idioms — Agent Context

This project uses [rubocop-monolith-idioms](https://github.com/NewAlexandria/rubocop-monolith-idioms), a RuboCop extension for idiomatic Ruby naming and Rails monolith patterns.  It ships with one cop (`Naming/MethodNameGetPrefix`) and is designed to be forked and extended with domain-specific cops.

## Commands

```bash
bundle install                # install dependencies
bundle exec rspec             # run all tests
bundle exec rspec spec/rubocop/cop/naming/method_name_get_prefix_spec.rb  # run single spec
bundle exec rubocop           # lint the gem's own code
bundle exec rubocop --only Naming/MethodNameGetPrefix path/to/file.rb     # run a single cop
bundle exec rake 'new_cop[Department/CopName]'   # scaffold a new cop
```

CI runs `bundle exec rspec` then `bundle exec rubocop` across Ruby 3.1, 3.2, 3.3.

### Loading the gem

The gem is loaded as a RuboCop plugin (1.72+) or via `require`:

```yaml
# .rubocop.yml
plugins:
  - rubocop-monolith-idioms
```

### Adding a new cop

Follow the checklist in `docs/ADDING_COPS.md`:

1. `bundle exec rake 'new_cop[Department/CopName]'` — scaffolds cop, spec, manifest entry, config
2. Implement detection logic (AST visitor callback like `on_def`, `on_send`)
3. Add config to `config/default.yml`
4. Write specs covering offenses, non-offenses, and autocorrect
5. Add guide in `guides/`
6. Add changelog entry

### Expressing a pattern as a cop

A cop is a visitor that walks the Ruby AST. Override a callback like `on_def` or `on_send`, match the node against your pattern, and call `add_offense` with a clear message. If the fix is mechanical, add an `AutoCorrector` block that rewrites the source. Keep the detection predicate small and the message actionable — the developer reading the offense should know exactly what to change.

## Built-in cops

- **Naming/MethodNameGetPrefix** — Flags `get_`/`set_` method prefixes and suggests idiomatic alternatives. See [guides/naming-method-name-get-prefix.md](https://github.com/NewAlexandria/rubocop-monolith-idioms/blob/main/guides/naming-method-name-get-prefix.md).

## Primary examples in this repo

This repo can maintain per-cop example files in `docs/rubocop-monolith-idioms-examples/`. Each cop gets its own file: `Department-CopName.md` (e.g. `Naming-MethodNameGetPrefix.md`). Each entry includes Context (`good` | `bad` | `exception`) and an embedded code block. When reasoning about a cop or suggesting code changes, read that cop's examples file if it exists.

Run `bundle exec install-context` to copy the gem's Naming/MethodNameGetPrefix examples into this directory (examples are installed by default; use `--without-examples` to skip). Create one markdown file per cop with Context and embedded code blocks. Update as you add examples.

## Configuration

Default config lives in `config/default.yml`. Profiles (baseline, strict) are in `config/profiles/`. See [docs/RAILS_MONOLITH_SCOPE.md](https://github.com/NewAlexandria/rubocop-monolith-idioms/blob/main/docs/RAILS_MONOLITH_SCOPE.md) for scope and migration strategy.

## Style constraints

- Line length max 120 (`Layout/LineLength`)
- Target Ruby version 2.7
- `rubocop-rspec` is loaded for linting specs
- `RSpec/ExampleLength` max 15
