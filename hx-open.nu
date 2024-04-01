#!/usr/bin/env nu

use wezterm.nu [wez_list, wez_draw_pane, wez_pane_cmd]

def main [abs_path: string] {
  if (not ($abs_path| path exists)) {
    exit 0
  }

  let selected_file = $abs_path | str replace $'($env.PWD)/' ''
  let pane_program = "hx"
  let direct = "right"
  let pane_id = wez_draw_pane --percent 80 --direct $direct

  if (wez_list | where title =~ $pane_program and paneid == $pane_id | is-not-empty) {
    echo $':open ($selected_file)\r' | wez_pane_cmd --id $pane_id
  } else {
    echo $'($pane_program) ($selected_file)\r' | wez_pane_cmd --id $pane_id
  }

  wezterm cli activate-pane-direction --pane-id $pane_id $direct 
}
