# Rails Large-Codebase Rule Scope

This extension is targeted toward rules that help maintain consistency and idiomatic patterns in large Rails codebases. The scope may grow over time to include:

- **Naming** — Method naming conventions (`get_`/`set_` prefixes, predicates, mutators)
- **RailsArchitecture** — Boundary rules for modular monoliths, engines, and service layers
- **RailsSafety** — Dangerous patterns, anti-corruption boundary checks
- **RailsPerformance** — Query/loading anti-patterns common in monoliths

## Profiles

### Baseline (default)

The default configuration is conservative: only cops with broad applicability are enabled. Use this when first adopting the extension.

```yaml
# .rubocop.yml
plugins:
  - rubocop-method-name-get-prefix
```

### Strict

For teams that have addressed baseline violations and want additional enforcement. Currently identical to baseline; future cops will be added here as opt-in.

```yaml
# .rubocop.yml
plugins:
  - rubocop-method-name-get-prefix

inherit_from:
  - rubocop-method-name-get-prefix:config/profiles/strict.yml
```

## Migration strategy: audit first, then enforce

1. **Audit** — Run with `--format json` or `--format offenses` to see counts without failing CI.
2. **Exclude** — Use `Exclude` in `.rubocop.yml` for legacy areas you plan to refactor later.
3. **Enable gradually** — Start with one cop or one directory; expand as violations are fixed.
4. **Strict profile** — Once baseline is clean, consider the strict profile for new rules.

### Example: staged rollout

```yaml
# .rubocop.yml
plugins:
  - rubocop-method-name-get-prefix

# Phase 1: audit only (no CI failure)
Naming/MethodNameGetPrefix:
  Enabled: true
  Exclude:
    - 'legacy/**/*'
    - 'vendor/**/*'

# Phase 2: after fixing violations, remove Exclude or narrow it
```

## References

- [Flexport: Isolating Rails Engines with RuboCop](https://flexport.engineering/isolating-rails-engines-with-rubocop-210feaba3164)
- [Thoughtbot: Custom Cops for Custom Needs](https://thoughtbot.com/blog/rubocop-custom-cops-for-custom-needs)
- [RuboCop Extensions](https://docs.rubocop.org/rubocop/extensions.html)
