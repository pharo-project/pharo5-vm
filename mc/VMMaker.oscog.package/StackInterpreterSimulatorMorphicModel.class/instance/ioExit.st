buttons callbacks
ioExit
	vm ioExit
	displayView activeHand removeEventListener: self model.	"This is a bug as the user in vm ioExit may have cancelled the confirm t.m."
"^UserDialogBoxMorph inform: 'Toggle Transcript' title: 'TODO:'"