export def helix_status_line [] {
  wezterm cli get-text | split row -r '\n' | reverse | where ($it | str trim) != "" | get 0 | str trim | parse --regex '^(?<mode>\S+)\s+(?<filename>\S+).* (?<pos>\d+:\d+)'
}

export def helix_normal_mode [
  --id: int
] {
  echo $'(ansi escape)' | wez_pane_cmd --id $id
}

export def wez_list [] {
  wezterm cli list | lines | skip 1 | parse --regex '(?<winid>\d+)\s+(?<tabid>\d+)\s+(?<paneid>\d+)\s+(?<workspace>\w+)\s+(?<size>\d+x\d+)\s+(?<title>\w+)'
}

export def wez_draw_pane [
  --direct (-d): string 
  --percent (-c): int = 20
] {
  try { 
    wezterm cli get-pane-direction $direct | into int 
  } catch { 
    nu -c $"wezterm cli split-pane (if $direct != "down" {$"--($direct)"}) --percent ($percent)" | to text | into int 
  }
}

export def wez_close_pane [
  --id: int
] {
  wezterm cli kill-pane --pane-id $id
}

export def wez_pane_cmd [
  --id: int
] {
  wezterm cli send-text --pane-id $id --no-paste
}
