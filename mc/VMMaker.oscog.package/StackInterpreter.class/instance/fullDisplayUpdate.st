I/O primitive support
fullDisplayUpdate
	"Repaint the entire smalltalk screen, ignoring the affected rectangle. Used in some platform's code when the Smalltalk window is brought to the front or uncovered."
	<returnTypeC: #sqInt>
	self updateDisplayLeft: 0 Top: 0 Right: displayWidth Bottom: displayHeight.
	self ioForceDisplayUpdate