I/O primitive support
fullDisplayUpdate
	"Repaint the entire smalltalk screen, ignoring the affected rectangle. Used in some platform's code when the Smalltalk window is brought to the front or uncovered."

	| displayObj w h |
	displayObj := objectMemory splObj: TheDisplay.
	((objectMemory isPointers: displayObj) and: [(objectMemory lengthOf: displayObj) >= 4]) ifTrue: [
		w := self fetchInteger: 1 ofObject: displayObj.
		h := self fetchInteger: 2 ofObject: displayObj.
		self displayBitsOf: displayObj Left: 0 Top: 0 Right: w Bottom: h.
		self ioForceDisplayUpdate].
	^nil