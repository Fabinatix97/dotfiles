# dotfiles

This is my public dotfiles repository with configurations for Hyprland, Kitty and more.

## Setup

This repo is optimized for use with [GNU stow](https://www.gnu.org/software/stow/):

```bash
cd dotfiles

# Stow a single config
stow hyprland

# Stow multiple configs
stow hyprland kitty starship
```

## Personal Settings

Private configurations are kept in a separate private repository called `dotfiles-personal`, which is included here as a Git submodule. If this dotfiles repo is cloned, the submodule must be explicitly included:

```bash
cd dotfiles
git submodule update --init --recursive
```

> [!note]
> The dotfiles repo stores the exact commit hash of dotfiles-personal in its Git history. If you make changes to the `main` branch of dotfiles-personal, they are not automatically reflected here. You’ll need to manually update the submodule to get the latest state of the main branch.

## VS Code Extensions

To install all my frequently used VS Code extensions at once, run the following command

```bash
cd dotfiles
xargs -n 1 code --install-extension < vscode.extensions
```
