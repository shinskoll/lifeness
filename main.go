package main

import (
	"github.com/andlabs/ui"
)

var mainwin *ui.Window

func setupUI() {
	// WINDOW ==========================================
	// =================================================
	mainwin = ui.NewWindow("lifeness", 500, 70, true)
	mainwin.OnClosing(func(*ui.Window) bool {
		ui.Quit()
		return true
	})
	ui.OnShouldQuit(func() bool {
		mainwin.Destroy()
		return true
	})
}

func main() {
	ui.Main(setupUI)
}
