# Naming/MethodNameGetPrefix — examples (shipped with gem)

These examples are copied from the gem when you run `bundle exec install-context --with-examples`. Add your own repo-specific examples below.

## Example 1 (good)

- **Context:** good — use of `*_for` pattern instead of `get_`

```ruby
# frozen_string_literal: true

# Good: use of *_for pattern instead of get_
def user_for(id)
  User.find(id)
end
```

## Example 2 (good)

- **Context:** good — use of `=` method syntax instead of `set_`

```ruby
# frozen_string_literal: true

# Good: use of = method syntax instead of set_
def custom_var=(val)
  @custom_var = val
end
```

## Example 3 (bad)

- **Context:** bad — flags offense; prefer `user_for(id)` or `find_user(id)`

```ruby
# frozen_string_literal: true

# Bad: get_ prefix with arguments — prefer user_for(id) or find_user(id)
def get_user(id)
  User.find(id)
end
```

## Example 4 (exception)

- **Context:** exception — excluded by cop when in `*client*.rb`, `*api_client*.rb`, `*controller*.rb`, `app/api/`, or `lib/clients/`

```ruby
# frozen_string_literal: true

# Exception: get_ in API client file that calls get() — excluded by cop
# Place in app/clients/, lib/api_client*, app/controllers/, app/api/, or lib/clients/
def get_user(id)
  get("/users/#{id}")
end
```
