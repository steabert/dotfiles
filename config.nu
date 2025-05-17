# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# Path
#=============================================================================-#

$env.path ++= [
  "~/.azure/bin",
  "~/.cargo/bin",
  "~/.fzf/bin",
  "~/.local/bin",
  "~/.npm-global/bin",
  "~/.yarn/bin",
  "~/go/bin",
  "~/opt/go/bin",
  "~/opt/node/bin",
  "~/prog/bento4/bin",
  "~/prog/delta-0.15.0-x86_64-unknown-linux-musl",
]

# Alias
#=============================================================================-#

def lt [] { ls -al | sort-by modified }

# Theme
#=============================================================================-#

let dark_green = "#90b99f"

let earl_grey = {
    binary: w
    bool: w
    cellpath: w
    date: w
    duration: w
    filesize: w
    float: w
    header: wb
    hints: { fg: dgr attr: d }
    int: w
    leading_trailing_space_bg: w
    nothing: w
    range: w
    row_index: w
    separator: w
    string: w

    shape_bool: w
    shape_custom: w
    shape_externalarg: w
    shape_external: w
    shape_filepath: w
    shape_flag: w
    shape_float: w
    shape_garbage: h
    shape_globpattern: w
    shape_internalcall: w
    shape_int: w
    shape_literal: w
    shape_operator: w
    shape_range: w
    shape_signature: w
    shape_string: w
    shape_variable: w
}

let config = {
  buffer_editor: "hx"
  color_config: $earl_grey
  edit_mode: "vi"
  table: {
    mode: compact # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
  }
}

$env.config = $config

# Command defaults
#=============================================================================-#

$env.FZF_DEFAULT_COMMAND = 'fd --type f --no-ignore-vcs'
$env.LS_COLORS = ''
$env.MOZ_ENABLE_WAYLAND = 1
$env.RIPGREP_CONFIG_PATH = $"($env.HOME)/.ripgreprc"

# Prompt
#=============================================================================-#

def create_left_prompt [] {
    let path = pwd | str replace -r ('^' + $env.HOME) '~'
    let path_segment = if (is-admin) {
        $"(ansi red_bold)($path)"
    } else {
        $"(ansi white_bold)($path)"
    }

    # get the current branch / commit ref
    use std null-device
    let branch = (do -i { git rev-parse --abbrev-ref HEAD e> (null-device) } | str trim)
    let git_segment = if ($branch | str length) > 0 {
        $"(ansi reset) | (ansi {fg: $dark_green})($branch)" 
    }

    let prompt = $"($path_segment)($git_segment) "
    $prompt
}

$env.PROMPT_COMMAND = {|| create_left_prompt}
