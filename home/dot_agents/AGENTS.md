<!-- Managed by chezmoi (dotfiles: home/dot_agents/AGENTS.md). Edit the source, not this file. -->

# Global agent instructions

## Security: secrets & 1Password

- Access secrets only via the 1Password CLI with the service account in `OP_SERVICE_ACCOUNT_TOKEN`. It can read only the `DEV-AGENTS` vault.
- Before any `op` command, run `op whoami`. If it does not report a **service account**, or `OP_SERVICE_ACCOUNT_TOKEN` is empty, STOP and tell the user. Never fall back to the desktop app integration.
- Never run `op signin`, `op account add`, `--no-masking`, or anything that unsets or overrides `OP_SERVICE_ACCOUNT_TOKEN`.
- Never reference vaults other than `DEV-AGENTS` (e.g. `op://DEV/...` or `op://Private/...`). Never read the Keychain, browser stores, or `~/.config/op`.
- Prefer `op run --env-file=.env.tpl -- <cmd>` or `op inject` so secrets go straight to the process. Don't `op read` into the conversation, and never print, echo, log, base64 or write secret values to files, commits, or chat.
- If a task needs a secret that isn't in `DEV-AGENTS`, ask the user to add it there. Don't look for it elsewhere.
