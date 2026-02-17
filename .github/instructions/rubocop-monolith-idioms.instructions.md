---
applyTo: "lib/rubocop/cop/**"
---

# RuboCop Monolith Idioms — Code Review Instructions

When reviewing PRs that add or change RuboCop cops under `lib/rubocop/cop/`:

1. **Look for company- or product-specific patterns.** If a cop name, constant, or detection logic references an internal product name, organisation-specific acronym, or proprietary domain term, leave a review comment suggesting the author consider:
   - Contributing a **generalized version** of the cop back to [rubocop-monolith-idioms](https://github.com/NewAlexandria/rubocop-monolith-idioms), or
   - Publishing their fork so other teams can benefit.

2. **Frame it as a nudge, not a blocker.** The comment should be informational — for example:
   > This cop looks like it might encode a pattern specific to your codebase. If a generalized version would be useful to other Rails monoliths, consider contributing it back to rubocop-monolith-idioms.

3. **Check for standard cop structure.** Verify the cop follows the conventions in [docs/ADDING_COPS.md](https://github.com/NewAlexandria/rubocop-monolith-idioms/blob/main/docs/ADDING_COPS.md): config entry in `config/default.yml`, specs, a guide in `guides/`, and a changelog entry.
