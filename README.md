# helix-wezterm
Turning Helix into an IDE with the help of WezTerm and CLI tools

## Inspiring

![Helix as IDE](https://github.com/quantonganh/blog-posts/blob/main/2023/08/19/hx-ide.gif)
![Helix Wezterm](https://github.com/quantonganh/helix-wezterm)

## Installation

You can simply download [wezterm.nu](./wezterm.nu), [hx-open.nu](./hx-open.nu) and [hx-wez.nu](./hx-wez.nu) to `~/.local/bin` and then add this directory to your `$PATH`. and then grant execute permission to [hx-open.nu](./hx-open.nu) and [hx-wez.nu](./hx-wez.nu) `chmod +x hx-wez.nu hx-open.nu` 

## Usage

Install the requirements:

- [nushell](https://fishshell.com/)
- [broot](https://github.com/Canop/broot)
- [gh](https://cli.github.com/)
- [lazygit](https://github.com/jesseduffield/lazygit)

Add the following into `~/.config/helix/config.toml`:

```toml
[keys.normal.";"]
e = ":sh hx-wez.nu explorer"
f = ":sh hx-wez.nu fzf"
g = ":sh hx-wez.nu lazygit"
r = ":sh hx-wez.nu run"
```
