debug support
debugDrawPtLineFrom: pt1 to: pt2
	| canvas |
	canvas := Display getCanvas.
	canvas
		line: pt1
		to: pt2
		width: 1
		color: Color red.