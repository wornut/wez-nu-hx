#!/usr/bin/env nu

use wezterm.nu [
  helix_status_line,
  helix_normal_mode,
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
  helix_normal_mode --id $env.WEZTERM_PANE


  draw_wez_pane_down
  wezterm cli activate-pane-direction down
}

def "main explorer" [] {
  helix_normal_mode --id $env.WEZTERM_PANE

  let pane_program = "broot" 
  let pane_direct = "left"
  let pane_id = wez_draw_pane --percent 20 --direct $pane_direct

  if (wez_list | where title =~ $pane_program | is-empty) {
    sleep 500ms | echo $"($pane_program)\r" | wez_pane_cmd --id $pane_id 
  } else {
    echo ":q\r" | wezterm cli send-text --pane-id $pane_id --no-paste
    wez_close_pane --id $pane_id
  }
   
  wezterm cli activate-pane-direction $pane_direct
}

def "main lazygit" [] {
  helix_normal_mode --id $env.WEZTERM_PANE

  let pane_id = draw_wez_pane_down
  let pane_program = "lazygit"

  if (wez_list | where title =~ $pane_program | is-empty) {
    sleep 500ms | echo "lazygit\r" | wez_pane_cmd --id $pane_id
  } else {
    wezterm cli activate-pane-direction down
  }
}

def "main fzf" [] {
  helix_normal_mode --id $env.WEZTERM_PANE


  let pane_id = draw_wez_pane_down

  sleep 500ms | echo "hx-fzf.nu\r" | wez_pane_cmd --id $pane_id
}

def main [] {}
