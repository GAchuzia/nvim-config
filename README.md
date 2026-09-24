# nvim-config

Requires **Neovim 0.11.3–0.11.x**, Git, ripgrep, Node.js/npm, and a C compiler. Tested on 0.11.6; 0.12 is not supported.

## Setup

On macOS/Linux, back up any existing `~/.config/nvim`, then link your checkout. Adjust the path if needed:

```sh
mkdir -p ~/.config
ln -s "$HOME/personal/nvim-config" "$HOME/.config/nvim"
nvim
```

Let plugins install, restart, and open a code file.

See [GUIDE.md](GUIDE.md) for installation details, keybindings, plugins, and troubleshooting.
