# rubocop-monolith-idioms — Agent Context

This project uses [rubocop-monolith-idioms](https://github.com/NewAlexandria/rubocop-monolith-idioms), a RuboCop extension for idiomatic Ruby naming and Rails monolith patterns.

## Loading the gem

The gem is loaded as a RuboCop plugin (1.72+) or via `require`:

```yaml
# .rubocop.yml
plugins:
  - rubocop-monolith-idioms
```

## Adding a new cop

1. Scaffold the cop:

   ```bash
   bundle exec rake 'new_cop[Department/CopName]'
   ```

2. Implement the detection logic in the generated file under `lib/rubocop/cop/<department>/`.

3. Follow the full checklist in [docs/ADDING_COPS.md](https://github.com/NewAlexandria/rubocop-monolith-idioms/blob/main/docs/ADDING_COPS.md): add config to `config/default.yml`, write specs, create a guide in `guides/`, and add a changelog entry.

### Expressing a pattern as a cop

A cop is a visitor that walks the Ruby AST. Override a callback like `on_def` or `on_send`, match the node against your pattern, and call `add_offense` with a clear message. If the fix is mechanical, add an `AutoCorrector` block that rewrites the source. Keep the detection predicate small and the message actionable — the developer reading the offense should know exactly what to change.

## Built-in cops

- **Naming/MethodNameGetPrefix** — Flags `get_`/`set_` method prefixes and suggests idiomatic alternatives. See [guides/naming-method-name-get-prefix.md](https://github.com/NewAlexandria/rubocop-monolith-idioms/blob/main/guides/naming-method-name-get-prefix.md).

## Configuration

Default config lives in `config/default.yml`. Profiles (baseline, strict) are in `config/profiles/`. See [docs/RAILS_MONOLITH_SCOPE.md](https://github.com/NewAlexandria/rubocop-monolith-idioms/blob/main/docs/RAILS_MONOLITH_SCOPE.md) for scope and migration strategy.
