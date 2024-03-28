#!/usr/bin/env nu

use wezterm.nu [
  helix_status_line,
  wez_list,
  wez_draw_pane,
  wez_close_pane,
  wez_pane_cmd
]

def draw_wez_pane_down [] {
  let pane_direct = "down"
  let pane_id = wez_draw_pane --percent 50 --direct $pane_direct

  wezterm cli activate-pane-direction $pane_direct

  if (not (wez_list | where title =~ "lazygit" | is-empty)) {
    echo "q" | wez_pane_cmd --id $pane_id
  } 

  $pane_id
}

def "main run" [] {
  draw_wez_pane_down
  wezterm cli activate-pane-direction down
}

def "main explorer" [] {
  let pane_program = "broot" 
  let pane_direct = "left"
  let pane_id = wez_draw_pane --percent 20 --direct $pane_direct

  if (wez_list | where title =~ $pane_program | is-empty) {
    sleep 500ms | echo $"($pane_program)\r\n" | wez_pane_cmd --id $pane_id 
  } else {
    echo ":q\r\n" | wezterm cli send-text --pane-id $pane_id --no-paste
    wez_close_pane --id $pane_id
  }
   
  wezterm cli activate-pane-direction $pane_direct
}

def "main lazygit" [] {
  let pane_id = draw_wez_pane_down
  let pane_program = "lazygit"

  if (wez_list | where title =~ $pane_program | is-empty) {
    sleep 500ms | echo "lazygit\r\n" | wez_pane_cmd --id $pane_id
  } else {
    wezterm cli activate-pane-direction down
  }
}

def "main fzf" [selected_file: string] {
  let pane_direct = "up"
  let top_pane_id = wez_draw_pane --direct $pane_direct

  if ($selected_file | is-empty) {
    exit 0
  }

  wezterm cli activate-pane-direction --pane-id $top_pane_id $pane_direct

  let command = {
    if (wez_list | where title =~ "hx" | is-not-empty) {
      $":open ($selected_file)\r\n"
    } else {
      $"hx ($selected_file)\r\n"
    }
  }

  echo $command | wez_pane_cmd --id $top_pane_id
}

def main [] {}
