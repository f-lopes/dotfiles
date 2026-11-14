# Dotfiles

Personal configuration managed by [chezmoi](https://www.chezmoi.io/). The
repository's `.chezmoiroot` points to `home/`, separating managed home files
from repository documentation, resources, and other metadata.

## Apply the configuration

For a local checkout, preview and apply with:

```sh
chezmoi --source ~/work/git/dotfiles diff
chezmoi --source ~/work/git/dotfiles apply
```

The `dev-env` bootstrap clones this repository and applies it with chezmoi.
Configure a different source with `CHEZMOI_DOTFILES_REPO`.

## Mise: global and project tools

`home/dot_config/mise/config.toml` becomes `~/.config/mise/config.toml` and is
the source of truth for everyday tools: Java, Maven, Go, Terraform, Starship,
the common CLI utilities, and Kubernetes tools. They are available from any
directory when mise is activated by the zsh setup.

The `dev-env` repository keeps bootstrap packages and hooks in `.mise.toml`,
along with project-scoped tools such as CMake, kind, Skaffold, Trivy, Infracost,
and the Junie CLI. Both configurations use mise's shared data directory, so
everyday tools are not downloaded twice.

## Zsh layout

The managed `~/.zprofile` sets up the login-shell environment (Homebrew, mise
shims, OrbStack), so global tools also resolve in IDEs and `zsh -l -c`.
The managed `~/.zshrc` loads `~/.config/zsh/zsh.d/*.zsh` in filename order.
Numbered prefixes define startup order:

1. `00-env.zsh` sets XDG defaults, editor, locale, and history.
2. `10-path.zsh` adds Homebrew on macOS and user PATH entries. Java and Maven
   come from mise (global config), not SDKMAN.
3. `20-mise.zsh` activates mise after manual PATH setup and adds its shims for
   non-interactive tools.
4. `30-ohmyzsh.zsh`, `40-aliases.zsh`, and `50-tools.zsh` load optional shell
   integrations and aliases.
5. `80-prompt.zsh` initializes Starship last; `90-secrets.zsh` is an inert
   1Password example.

To add a fragment, create the next appropriately numbered `.zsh` file under
`home/dot_config/zsh/zsh.d/`. For an OS-dependent fragment, use `.zsh.tmpl` and
guard platform-specific commands with `.chezmoi.os`.

## App configuration

Add an app config under `home/dot_config/<app>/`; chezmoi maps
`dot_config` to `~/.config`. For example, Zellij reads
`~/.config/zellij/config.kdl`, and Starship reads
`~/.config/starship.toml`.

The Git template starts with the existing identity. To render a host-specific
identity, set `GIT_AUTHOR_NAME` and/or `GIT_AUTHOR_EMAIL` for the apply command,
for example:

```sh
GIT_AUTHOR_EMAIL=you@example.com chezmoi --source ~/work/git/dotfiles apply
```

## SSH config

`home/dot_ssh/config.tmpl` renders to `~/.ssh/config` and uses `onepasswordRead`
to pull server details from 1Password, so no IPs, ports, or usernames are stored
in the public repository. The OrbStack include line is static and safe to commit.

Before running `chezmoi apply`, create the following 1Password items (type: **Document**):

| 1Password Item | Field | Value |
|---------------|-------|-------|
| `DEV/florianlopes_io_server` | `ip_address` | Server IP address |
| | `port` | SSH port (e.g. `2432`) |
| | `username` | SSH username |
| `DEV/dedibox_server` | `ip_address` | Server IP address |
| | `port` | SSH port (e.g. `2432`) |
| | `username` | SSH username |

If a 1Password item is missing, `chezmoi apply` will fail with a clear error
message — create the item and retry. The Port line is conditional for both
hosts: it only renders when the `port` field has a value, so leaving it empty
defaults to port 22.

## Secrets and 1Password

Do not commit secret values. The `90-secrets.zsh.tmpl` examples are wrapped in
a Go-template comment so `chezmoi apply` neither reads 1Password nor requires
the `op` CLI. To enable one, customize its `op://` reference, remove the outer
`{{/* ... */}}` comment wrapper and the shell-comment marker, then apply while
the 1Password CLI is installed and signed in. The value is rendered into the
target file, so keep the rendered file private and never commit it.

The examples cover a GitHub token, an Anthropic API key, and a Maven repository
password. Other common secret material includes package-registry tokens,
cloud-provider credentials, SSH or signing private keys, Kubernetes credentials,
`.netrc` entries, and Terraform or artifact-service tokens. For a structured
file such as `~/.m2/settings.xml`, create a dedicated chezmoi template and use
`onepasswordRead` for only the credential field rather than placing the whole
file in this shell fragment.

## Repository follow-up

The `origin` remote is `git@github.com:f-lopes/dotfiles.git`. Publish the
managed `home/` tree there so fresh `dev-env` bootstraps can apply the same
configuration shown in this checkout.