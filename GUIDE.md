# Guide

**Space is the leader key.** Press it and pause to see shortcuts.

## Setup

### Requirements

- Neovim **0.11.3–0.11.x** (tested on 0.11.6). Treesitter's `master` branch and Blink v1 target 0.11; this config does not support 0.12.
- Git, ripgrep (`rg`), curl, tar, and a C compiler for syntax parsers.
- Node.js LTS with working npm for web language servers.
- Internet access for initial downloads.
- Optional: [LazyGit](https://github.com/jesseduffield/lazygit#installation) for `Space gg`.

Check `rg --version`, `node --version`, and `npm --version` in the shell you use to launch Neovim. Missing ripgrep breaks text search; broken npm prevents web language-server installs. With Homebrew, `brew install ripgrep lazygit` installs the search and Git tools.

### Install Neovim on Apple Silicon

If `nvim --version` already reports a supported version, skip to [Link the config](#link-the-config).

Run each line in the same terminal. Stop if a command fails.

```sh
base="https://github.com/neovim/neovim/releases/download"
curl -fL -o /tmp/nvim.tar.gz "$base/v0.11.6/nvim-macos-arm64.tar.gz"
```

After the download succeeds:

```sh
dest="$HOME/.local/opt/nvim-0.11.6"
mkdir -p "$dest" "$HOME/.local/bin"
tar -xzf /tmp/nvim.tar.gz -C "$dest" --strip-components=1
"$dest/bin/nvim" --version
```

Link the executable:

```sh
ln -s "$dest/bin/nvim" "$HOME/.local/bin/nvim"
```

If the link already exists, check it with `ls -l "$HOME/.local/bin/nvim"`. Keep it if it points to the binary above. Don't overwrite an unrelated file or link.

Add it to this terminal's PATH:

```sh
export PATH="$HOME/.local/bin:$PATH"
nvim --version
```

For future zsh login sessions, add the setting without duplicating it:

```sh
touch ~/.zprofile
line='export PATH="$HOME/.local/bin:$PATH"'
grep -qxF "$line" ~/.zprofile || echo "$line" >> ~/.zprofile
```

### Other systems

Download the matching build from the [Neovim 0.11.6 release](https://github.com/neovim/neovim/releases/tag/v0.11.6), add its executable directory to PATH, and check `nvim --version`.

### Windows (native)

Use Windows Terminal and install Neovim **0.11.6** from the release linked above. Extract the Windows archive and add its `bin` directory to your user PATH. Avoid installing a newer Neovim version until this config is updated for it.

Install the supporting tools in PowerShell (skip anything already installed):

```powershell
winget install --id Git.Git -e
winget install --id BurntSushi.ripgrep.MSVC -e
winget install --id OpenJS.NodeJS.LTS -e
```

LazyGit is optional:

```powershell
winget install --id JesseDuffield.lazygit -e
```

Treesitter also needs a Windows C compiler. One option is Visual Studio Build Tools with the **Desktop development with C++** workload; launch Neovim from its Developer PowerShell so `cl.exe` and the SDK are available. See [Treesitter's Windows notes](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support) for other toolchains.

Open a fresh terminal after installing tools and check:

```powershell
nvim --version
rg --version
node --version
npm.cmd --version
```

Clone directly into Neovim's config directory to avoid symlink permissions. Replace the URL below with your repo URL. Back up any existing destination first:

```powershell
$repo = "https://github.com/YOUR-USER/nvim-config.git"
git clone $repo "$env:LOCALAPPDATA\nvim"
nvim
```

If the checkout already lives elsewhere, you can use a directory junction instead. The destination must not exist:

```powershell
$source = "$HOME\src\nvim-config"
$target = "$env:LOCALAPPDATA\nvim"
New-Item -ItemType Junction -Path $target -Target $source
```

If PowerShell blocks `npm.ps1`, use `npm.cmd` rather than weakening your execution policy. If search fails, check `:echo executable('rg')`; it should return `1`. File search can fall back to Windows `where`, but text search still needs `rg`. `:set shell?` shows which shell the built-in terminal uses.

The config has been tested on macOS, not Windows. On Windows, run `:checkhealth`, `:checkhealth vim.lsp`, and `:ConformInfo` after installation; check clipboard and terminal behavior too.

### Moving between machines

Use the same repo revision and commit `lazy-lock.json`. Run `:Lazy restore` to use the pinned plugin revisions. Install external tools separately on each machine; the lockfile does not pin Neovim, Mason tools, Node, or LazyGit.

Copy or clone only the config—not downloaded plugins, Mason packages, or compiled parsers. Let Neovim install those for the new OS. `:echo stdpath('config')` and `:echo stdpath('data')` show the active directories.

WSL is another option: follow the Linux setup inside WSL, use Linux binaries, and keep the config at `~/.config/nvim`. Native Windows and WSL are separate installations.

### Link the config

On macOS/Linux, use your checkout's path below. The command works from any directory.

If `~/.config/nvim` exists, inspect it first. Keep a correct link; back up another config before replacing it. For an incorrect **symlink**, `unlink "$HOME/.config/nvim"` removes the link without deleting its target. Don't use it on a real directory.

```sh
mkdir -p ~/.config
ln -s "$HOME/personal/nvim-config" "$HOME/.config/nvim"
```

For Windows, use the clone or junction steps above. The config link does not install Neovim itself.

### First launch

Run `nvim` and let plugins and parsers install. Restart and open a code file to trigger language-server installs. `:Mason` shows tool installation progress; `:checkhealth` reports setup issues.

## What's included

12 plugins total, including the manager and shared dependency:

| Plugin | Purpose |
| --- | --- |
| lazy.nvim | Plugin management and lockfile |
| catppuccin | Colors |
| telescope.nvim + plenary.nvim | File, text, and symbol search |
| nvim-treesitter | Syntax highlighting |
| nvim-lspconfig | Language server definitions |
| mason.nvim + mason-lspconfig.nvim | Install and enable language servers |
| blink.cmp (v1) | Code, path, and buffer completion |
| conform.nvim | Explicit formatting |
| gitsigns.nvim | Changed-line markers, hunk preview/staging, blame |
| which-key.nvim | Shortcut help |

File browsing, terminals, commenting, diagnostics, EditorConfig, and persistent undo use Neovim's built-ins.

## Everyday use

Start from a project's root so searches and terminals use the right directory:

```sh
cd /path/to/project
nvim .
```

`i` enters Insert mode; `Esc` returns to Normal mode. `u` undoes, `Ctrl-r` redoes. `:w` saves, `:q` closes a window. Use `:Tutor` for an interactive introduction.

| Keys (Normal mode unless noted) | Action |
| --- | --- |
| `Ctrl-p` / `Space ff` | Find files |
| `Space fg` / `Space fw` | Search project text / word under cursor |
| `Space fb` / `Space fr` | Open buffers / recent files |
| `Space fh` / `Space fk` | Search help / keybindings |
| `Ctrl-n` / `Space e` | Toggle built-in file explorer |
| `Space w` / `Space q` | Save / close window |
| `Shift-h` / `Shift-l` | Previous / next buffer |
| `Space bd` | Close buffer |
| `Ctrl-h/j/k/l` | Move between windows |
| `Space \|` / `Space -` | Vertical / horizontal split |
| `gd` / `gr` / `K` | Definition / references / hover docs |
| `Ctrl-o` / `Ctrl-i` | Back / forward in jump history |
| `Space cr` / `Space ca` | Rename symbol / code action |
| `Space cs` | Document symbols |
| `[d` / `]d` / `Space cd` | Previous / next / explain diagnostic |
| `Space xx` | Search reported diagnostics |
| `Space cf` | Format buffer or Visual selection |
| `gcc` / Visual `gc` | Comment line / selection |
| `Space gg` | Open LazyGit in a full-size terminal tab |
| `[h` / `]h` | Previous / next Git hunk |
| `Space ghp` / `Space ghs` | Preview / stage or unstage hunk |
| `Space ghr` | **Discard changes in hunk** |
| `Space gb` / `Space gd` | Blame line / diff against index |
| `Space tt` | Open a new terminal split |
| `Space pm` / `Space pl` | Manage language tools / plugins |

**Completion (Insert mode):** `Ctrl-Space` opens the menu, `Ctrl-n/p` selects, `Ctrl-y` accepts, `Ctrl-e` dismisses. Enter stays a newline. `Tab` / `Shift-Tab` move through snippet fields supplied by an LSP.

**Search:** press `Esc` to enter Normal mode, then `Ctrl-p` (or Space, f, f) to search **filenames**. Use Space, f, g to search **text inside files**. Type to filter; `Enter` opens, `Ctrl-v` opens in a vertical split. `Esc` leaves the picker's Insert mode; press it again to close. Dotfiles are included and common dependency/build folders are excluded. File search falls back to `fd`, `find`, or Windows `where` if `rg` is missing. The `find` and `where` fallbacks do not respect `.gitignore`.

If search is empty or fails:
- `:pwd` shows the search directory. Use `:cd /path/to/project` to change it.
- `:echo executable('rg')` should print `1`. Text search requires ripgrep (`rg`) on Neovim's PATH. Install it through your package manager (e.g. `brew install ripgrep`), then reopen Neovim from that shell.
- `:messages` shows errors. Ignored files won't appear when using `rg` or `fd`; use the explorer if needed.

**Explorer:** `Enter` opens a file/directory, `-` goes up, `%` creates a file, `d` creates a directory, `R` renames, and `D` deletes. Use `:help netrw` for more.

**Terminal:** run dev servers, tests, and Git commands normally. `Esc Esc` returns to Normal mode; `i` resumes typing. `:hide` hides the terminal without stopping its process; reopen it with `Space fb`. `Ctrl-c` stops a foreground command; `exit` closes the shell. Each `Space tt` creates a new terminal, not a toggle.

## Visual Git dashboard

LazyGit is an optional standalone terminal app, not a Neovim plugin. With `lazygit` on your PATH, save your files and press **Space gg** in Normal mode. It opens the repository containing your current working directory (`:pwd`). Use `:cd /path/to/repo` to switch repositories first.

In LazyGit's **Files** panel:
- `j` / `k` or arrow keys select a file; the diff appears alongside it.
- `Space` toggles staging for the selected file.
- `Enter` opens the detailed diff for staging individual lines/hunks; follow the key hints at the bottom.
- `c` opens the commit dialog for staged changes.
- `?` shows available actions for the focused panel.
- `q` quits LazyGit; on a normal exit, its tab closes and returns you to editing.

Nothing is staged, committed, or pushed automatically. Review discard/reset actions carefully. If you leave terminal input mode with `Esc Esc`, press `i` to interact with LazyGit again.

## Language support and formatting

Mason installs the configured language servers when you open a code file. Install each language's runtime and project dependencies separately.

| Language | Server | Formatting (`Space cf`) |
| --- | --- | --- |
| Lua | `lua_ls` | StyLua |
| JavaScript / TypeScript / JSX / TSX | `ts_ls` | Prettier |
| HTML / CSS / JSON | `html`, `cssls`, `jsonls` | Prettier |
| Ruby | `ruby_lsp` | Ruby LSP's project formatter |
| Python | `pyright` | Ruff |
| SQL | `sqls` | sql-formatter |
| Go | `gopls` | gofmt |
| C / C++ | `clangd` | clang-format |

Treesitter highlighting is included for these languages and Go module files.

**Formatting is manual, not on save.** Install the external formatters you need:

```vim
:MasonInstall stylua prettier ruff sql-formatter clang-format
```

Prettier prefers project-local installations and settings. `gofmt` comes with Go. Ruby uses LSP formatting when the project provides a supported formatter, such as RuboCop. If an external formatter is missing, Conform falls back to an attached LSP formatter when available.

### Language setup notes

- **Ruby:** use the project's Ruby version, with RubyGems and Bundler working before starting Neovim. Install the project's gems. Ruby LSP may create a `.ruby-lsp` bundle; don't commit generated editor dependencies. On Windows, native gems may need RubyInstaller's Devkit.
- **Python:** install Python and activate the project's virtual environment before launching Neovim. Pyright itself installs through npm. Ruff here is a formatter, not an additional lint server.
- **SQL:** install Go so Mason can build `sqls`. Schema-aware completion needs a database connection configured privately in sqls. No connection credentials or query-running shortcuts are included. sql-formatter defaults to standard SQL; set its dialect for dialect-specific syntax.
- **Go:** install a current Go toolchain and work from a module with `go.mod` or a workspace with `go.work`. Mason builds `gopls` using Go.
- **C/C++:** install the project's compiler/build tools. Generate `compile_commands.json` for accurate flags, headers, and navigation; CMake supports `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON` with Ninja/Makefile generators. Use `.clang-format` for project formatting rules.

After installing a missing runtime, restart Neovim and open a source file to retry the server install. Check `:Mason`, `:checkhealth vim.lsp`, and `:ConformInfo` if a tool is unavailable.

## Extend only when needed

For other languages, open a code file and use `:LspInstall`, for example `rust_analyzer`, `eslint`, or `yamlls`. Mason-installed servers are enabled automatically.

Add parsers with `:TSInstall rust` (or another language), and formatter mappings in `lua/plugins/formatting.lua` as needed. Prettier also handles JSONC and Markdown.

## Maintenance

- `:Lazy restore` restores the committed plugin versions; `:Lazy update` intentionally updates them. Review the lockfile diff.
- `:TSUpdate` updates parsers to match Treesitter.
- `:Mason` shows installed tools; `:MasonLog` explains installation failures.
- `:checkhealth vim.lsp` checks attached servers; `:ConformInfo` explains formatting.
- `:checkhealth` and `:messages` help with startup/runtime issues.
- If tools fail to install, verify `node --version` and `npm --version` in the shell launching Neovim.

Use the health checks above after changing or updating the config.

### File map

`init.lua` checks the Neovim version, loads the core modules, and starts Lazy; change it for startup behavior. In `lua/config/`, edit `options.lua` for indentation, display, and clipboard defaults; `keymaps.lua` for general shortcuts and the LazyGit launcher; and `autocmds.lua` for yank highlighting, diagnostic display, and mappings that appear when an LSP attaches. In `lua/plugins/`, `colorscheme.lua` selects and configures the theme; `completion.lua` sets completion sources and popup behavior; `editor.lua` names the shortcut groups in which-key; `formatting.lua` maps filetypes to formatters; `git.lua` configures Gitsigns and its buffer-local shortcuts; `lsp-config.lua` lists default servers and their settings; `telescope.lua` defines search pickers, shortcuts, and exclusions; and `treesitter.lua` selects parsers and highlighting settings. Edit the relevant file, then restart Neovim to apply it.

`README.md` is the quick-start page; `GUIDE.md` holds the detailed instructions—update these when behavior changes. `lazy-lock.json` records exact plugin revisions; let Lazy maintain it rather than editing hashes by hand. `.stylua.toml` defines how this repo's Lua is formatted; adjust it to change the coding style. `.gitignore` keeps swap files, backups, and macOS metadata out of Git; extend it for local artifacts, not files the config needs.
