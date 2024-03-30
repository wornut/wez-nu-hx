#!/usr/bin/env nu

use wezterm.nu [wez_draw_pane, wez_list, wez_pane_cmd]

def main [] {
  let selected_file =  try {
    rg --line-number --column --no-heading --smart-case . | fzf --delimiter : --preview 'bat --style=full --color=always --highlight-line {2} {1}' --preview-window '~3,+{2}+3/2' | parse --regex '(?<target>^\w.*\d+:\d+)' | get 0.target  
  } catch {
    ""
  }
  let pane_direct = "up"
  let top_pane_id = wez_draw_pane --direct $pane_direct

  if (not ($selected_file | str replace --regex '\:\d+\:\d+' '' | path exists)) {
    wezterm cli zoom-pane --pane-id $top_pane_id
    exit 0 
  }

  wezterm cli activate-pane-direction --pane-id $top_pane_id $pane_direct
  wezterm cli zoom-pane --pane-id $top_pane_id

  sleep 500ms

  if (wez_list | where title =~ "hx" | is-not-empty) {
    $":open ($selected_file)\r" | wez_pane_cmd --id $top_pane_id
  } else {
    $"hx -w ($selected_file)\r" | wez_pane_cmd --id $top_pane_id
  }
}
