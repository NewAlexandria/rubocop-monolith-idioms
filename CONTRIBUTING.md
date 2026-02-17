# Contributing

Thanks for your interest in contributing to **rubocop-monolith-idioms**.

## Getting started

- [README](README.md) — how to install, use, and fork the gem.
- [docs/ADDING_COPS.md](docs/ADDING_COPS.md) — step-by-step guide for adding a new cop.
- [docs/RAILS_MONOLITH_SCOPE.md](docs/RAILS_MONOLITH_SCOPE.md) — scope, profiles, and migration strategy.

## Development

After checking out the repo, run `bundle install` to install dependencies and `bundle exec rspec` to run the tests. Open issues or PRs on [GitHub](https://github.com/NewAlexandria/rubocop-monolith-idioms).

## Agent context

If you use an AI editor agent, run `bundle exec install-context` to install an `AGENTS.md` context doc that tells the agent how the gem works and how to add cops.

## Copilot code review

This repo includes a [`.github/instructions/rubocop-monolith-idioms.instructions.md`](.github/instructions/rubocop-monolith-idioms.instructions.md) file that instructs the GitHub Copilot code-review agent to nudge when a cop looks company-specific.

To enable automatic Copilot code review on your fork:

1. Go to **Settings → Rules → Rulesets** in your repository.
2. Create or edit a branch ruleset for your default branch.
3. Enable **"Request pull request review from Copilot"**.
4. See the [GitHub docs on configuring automatic Copilot review](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/request-a-code-review/configure-automatic-review) for details.
