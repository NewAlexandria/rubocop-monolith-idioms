# Naming/MethodNameGetPrefix

## Rule Details

Flags methods with `get_` or `set_` prefixes that take arguments, suggesting more idiomatic Ruby naming conventions.

## Rationale

In Ruby, `get_` and `set_` prefixes are non-idiomatic when used beyond the attr accessor pattern. For methods with arguments:

- `get_` prefixed methods should use `*_for` (e.g., `user_for(id)`) or `find_*` (e.g., `find_user(id)`) patterns.
- `set_` prefixed methods with a single argument should use the `=` method syntax (e.g., `user=(val)`).

## Examples

### Incorrect code for this rule

```ruby
def get_user(id)
  User.find(id)
end

def set_custom_var(val)
  @custom_var = val
end
```

### Correct code for this rule

```ruby
def user_for(id)
  User.find(id)
end

def custom_var=(val)
  @custom_var = val
end
```

## Exclusions

- Accessor methods (no arguments) — handled by `Naming/AccessorMethodName`
- Methods that make HTTP GET requests (e.g., `connection.get`, `HTTP.get`, `Net::HTTP::Get.new`)
- API client methods in files matching `*client*.rb`, `*controller*.rb`, `/api/`, `/clients/` that call `get()`
- `set_` methods with 2+ required arguments

## Configuration

```yaml
Naming/MethodNameGetPrefix:
  Enabled: true
```

## Auto-correction

The cop supports auto-correction. It renames method definitions only; call sites must be updated separately.
