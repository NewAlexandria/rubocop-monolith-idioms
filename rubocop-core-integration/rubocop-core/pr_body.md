**Summary**

This PR adds a new `Naming/MethodNameGetPrefix` cop that flags methods with `get_` or `set_` prefixes that take arguments, suggesting more idiomatic Ruby naming conventions.

**Changes**

- Added `Naming/MethodNameGetPrefix` cop in `lib/rubocop/cop/naming/method_name_get_prefix.rb`
- Added comprehensive test suite in `spec/rubocop/cop/naming/method_name_get_prefix_spec.rb`
- Added cop configuration to `config/default.yml`
- Added cop documentation to `docs/modules/ROOT/pages/cops/naming.adoc`
- Added changelog entry

**What the cop does**

The cop flags methods that:

- Start with `get_` prefix and take one or more arguments
- Start with `set_` prefix and take a _single_ required argument (without defaults)

For `get_` prefixed methods, it suggests renaming them to use more idiomatic Ruby patterns:

- `*_for` pattern (e.g., `get_user(id)` → `user_for(id)`)
- `find_*` pattern (e.g., `get_user(id)` → `find_user(id)`)

For `set_` prefixed methods with a single required argument:

- Regular methods: suggests using `=` method syntax (e.g., `set_user(val)` → `user=(val)`)
- API client methods: suggests `create_`, `put_`, or `update_` prefixes (e.g., `set_user(data)` → `create_user(data)`)

**Exclusions**

The cop automatically excludes:

1. Accessor methods (methods without arguments) - handled by `Naming/AccessorMethodName`
2. Methods that make HTTP GET requests (e.g., `connection.get`, `HTTP.get`, `Net::HTTP::Get.new`)
3. API client methods in files matching patterns like `*client*.rb`, `*controller*.rb`, etc. that call `get()`
4. `set_` methods with 2+ required arguments (since `=` suffix is only idiomatic for single-argument setters)

**Examples**

```ruby
# Bad - get_ prefix
def get_user(id)
  User.find(id)
end

# Good - get_ prefix
def user_for(id)
  User.find(id)
end

# Also good - get_ prefix
def find_user(id)
  User.find(id)
end

# Bad - set_ prefix (single argument)
def set_custom_var(val)
  @custom_var = val
end

# Good - set_ prefix (single argument)
def custom_var=(val)
  @custom_var = val
end

# Allowed - set_ prefix (2+ arguments)
def set_user(id, name)
  @user = User.new(id: id, name: name)
end
```

**Auto-correction**

The cop supports auto-correction to rename method definitions. Note that call sites would need to be updated separately.

---

Before submitting the PR make sure the following are checked:

- [x] The PR relates to _only_ one subject with a clear title and description in grammatically correct, complete sentences.
- [x] Wrote [good commit messages][1].
- [x] Commit message starts with `[Fix #issue-number]` (if the related issue exists).
- [x] Feature branch is up-to-date with `master` (if not - rebase it).
- [x] Squashed related commits together.
- [x] Added tests.
- [x] Ran `bundle exec rake default`. It executes all tests and runs RuboCop on its own code.
- [x] Added an entry (file) to the [changelog folder](https://github.com/rubocop/rubocop/blob/master/changelog/) named `{change_type}_{change_description}.md` if the new code introduces user-observable changes. See [changelog entry format](https://github.com/rubocop/rubocop/blob/master/CONTRIBUTING.md#changelog-entry-format) for details.

[1]: https://chris.beams.io/posts/git-commit/
