# RuboCop Core Integration

This directory contains all files needed for contributing the `Naming/MethodNameGetPrefix` cop to RuboCop core.

## File Mapping

Copy files from the `rubocop-core-integration/` directory to your RuboCop fork as follows:

### Core Files

1. **Cop Implementation**

   - Source: `rubocop-core-integration/rubocop-core/lib/rubocop/cop/naming/method_name_get_prefix.rb`
   - Destination: `lib/rubocop/cop/naming/method_name_get_prefix.rb`

2. **Test Suite**
   - Source: `rubocop-core-integration/rubocop-core/spec/rubocop/cop/naming/method_name_get_prefix_spec.rb`
   - Destination: `spec/rubocop/cop/naming/method_name_get_prefix_spec.rb`

### Configuration Files

3. **Cop Configuration**

   - Source: `rubocop-core-integration/rubocop-core/config_default_yml_snippet.yml`
   - Destination: Add the content to `config/default.yml` under the `Naming` section

4. **Documentation**

   - Source: `rubocop-core-integration/rubocop-core/docs_naming_adoc_snippet.adoc`
   - Destination: Add the content to `docs/modules/ROOT/pages/cops/naming.adoc` (or appropriate location)

5. **Changelog Entry**
   - Source: `rubocop-core-integration/rubocop-core/changelog/new_feature_add_naming_method_name_get_prefix_cop.md`
   - Destination: `changelog/new_feature_add_naming_method_name_get_prefix_cop.md`

### GitHub Files

6. **Issue Body**

   - Source: `rubocop-core-integration/rubocop-core/issue_body.md`
   - Usage: Use with `gh issue create --body-file` command

7. **PR Body**
   - Source: `rubocop-core-integration/rubocop-core/pr_body.md`
   - Usage: Use with `gh pr create --body-file` command (update issue number first)

## Copy Instructions

### Option 1: Manual Copy

1. Navigate to your RuboCop fork directory
2. Copy each file to its destination path
3. For configuration snippets, manually add the content to the target files

### Option 2: Using Script

From the `rubocop-core-integration/rubocop-core/` directory, you can use:

```bash
# Set the path to your RuboCop fork
RUBOCOP_FORK=/path/to/rubocop

# Copy core files
cp lib/rubocop/cop/naming/method_name_get_prefix.rb \
   $RUBOCOP_FORK/lib/rubocop/cop/naming/method_name_get_prefix.rb

cp spec/rubocop/cop/naming/method_name_get_prefix_spec.rb \
   $RUBOCOP_FORK/spec/rubocop/cop/naming/method_name_get_prefix_spec.rb

cp changelog/new_feature_add_naming_method_name_get_prefix_cop.md \
   $RUBOCOP_FORK/changelog/new_feature_add_naming_method_name_get_prefix_cop.md

# For config and docs, manually add the snippets to the target files
```

## Verification Steps

After copying files:

1. **Run tests:**

   ```bash
   bundle exec rspec spec/rubocop/cop/naming/method_name_get_prefix_spec.rb
   ```

2. **Run full test suite:**

   ```bash
   bundle exec rake default
   ```

3. **Verify cop is registered:**

   - Check that `config/default.yml` includes the cop configuration
   - Check that documentation is added to the appropriate docs file

4. **Test the cop manually:**
   ```bash
   bundle exec rubocop --only Naming/MethodNameGetPrefix test_file.rb
   ```

## Notes

- Update the issue number in `pr_body.md` before creating the PR
- The changelog entry includes `[#xxxx]` placeholder - replace with actual issue number
- Ensure your fork's main branch is up to date with upstream before creating the PR branch
