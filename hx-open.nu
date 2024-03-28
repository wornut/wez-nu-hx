#!/usr/bin/env nu

use wezterm.nu [wez_list, wez_draw_pane]

def main [selected_file: string] {
  if (not ($selected_file | path exists)) {
    exit 0
  }

  let direct = "right"
  let pane_id = wez_draw_pane --percent 80 --direct $direct

    let command = {
      if (wez_list | where title =~ "hx" | is-not-empty) {
        $":open ($selected_file)\r\n"
      } else {
        $"hx ($selected_file)\r\n"
      }
  }

  echo $command | wezterm cli send-text --pane-id $pane_id --no-paste
  wezterm cli activate-pane-direction --pane-id $pane_id $direct 
}
