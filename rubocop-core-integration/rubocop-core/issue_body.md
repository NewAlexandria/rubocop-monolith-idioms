## Is your feature request related to a problem? Please describe.

Ruby methods with `get_` or `set_` prefixes are non-idiomatic when used beyond the attr accessor pattern, or certain API calls. The `get_` prefix is typically used for accessor methods (getters), but when a method takes arguments, it's more idiomatic in Ruby to use patterns like `*_for` (e.g., `user_for(id)`) or `find_*` (e.g., `find_user(id)`). Similarly, `set_` prefixed methods with a single argument should use the `=` method syntax (e.g., `set_user(val)` → `user=(val)`), which is the idiomatic Ruby way for setters.

Currently, RuboCop has `Naming/AccessorMethodName` which handles accessor methods (methods without arguments), but there's no cop to flag non-idiomatic `get_` or `set_` prefixed methods that take arguments.

## Describe the solution you'd like

Add a new `Naming/MethodNameGetPrefix` cop that:

- Flags methods starting with `get_` that take one or more arguments
  - Suggests renaming to `*_for` pattern (e.g., `get_user(id)` → `user_for(id)`)
- Flags methods starting with `set_` that take a _single_ required argument
  - For regular methods: suggests using `=` method syntax (e.g., `set_user(val)` → `user=(val)`)
  - For API client methods: suggests `create_`, `put_`, or `update_` prefixes (e.g., `set_user(data)` → `create_user(data)`)
- Excludes `set_` methods with 2+ required arguments (since `=` suffix is only idiomatic for single-argument setters)
- Supports auto-correction to rename method definitions
- Automatically excludes:
  - Accessor methods (no arguments) - already handled by `Naming/AccessorMethodName`
  - Methods that make HTTP GET requests (e.g., `connection.get`, `HTTP.get`, `Net::HTTP::Get.new`)
  - API client methods in files matching patterns like `*client*.rb`, `*controller*.rb`, etc. that call `get()`

## Describe alternatives you've considered

1. **Making the suggested pattern configurable** - Considered but decided to default to `*_for` pattern for `get_` methods as it's more common in Ruby codebases. The cop message also mentions `find_*` as an alternative.

2. **Only flagging certain patterns** - Considered being more restrictive, but decided to flag all `get_*` methods with arguments and let developers decide on exclusions via configuration if needed.

3. **Separate cop for HTTP GET exclusions** - Considered splitting the HTTP GET detection into a separate cop, but decided to include it in this cop since it's a common false positive scenario.

4. **Flagging all `set_` methods regardless of argument count** - Decided to exclude `set_` methods with 2+ required arguments since the `=` suffix is only idiomatic for single-argument setters in Ruby.

## Additional context

- The cop includes HTTP GET request detection to exclude API client methods, which is a common use case where `get_` prefix is acceptable
- Supports auto-correction to rename method definitions (though call sites would need to be updated separately)
- The exclusion logic for HTTP GET requests covers common patterns like `connection.get`, `HTTP.get`, `RestClient.get`, `Faraday.get`, `Net::HTTP::Get.new`, and `http.request`/`https.request`
- For `set_` methods in API files, the cop suggests `create_`, `put_`, or `update_` prefixes instead of the `=` suffix, as these are more appropriate for API operations
