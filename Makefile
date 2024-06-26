install:
	mkdir -p ~/.local/bin
	cp wezterm.nu ~/.local/bin
	cp hx-wez.nu ~/.local/bin
	cp hx-open.nu ~/.local/bin
	cp hx-fzf.nu ~/.local/bin
	# or create soft link

	chmod +x ~/.local/bin/hx-wez.nu 
	chmod +x ~/.local/bin/hx-open.nu 
	chmod +x ~/.local/bin/hx-fzf.nu 

uninstall:
	rm -f ~/.local/bin/wezterm.nu
	rm -f ~/.local/bin/hx-wez.nu
	rm -f ~/.local/bin/hx-open.nu
	rm -f ~/.local/bin/hx-fzf.nu
