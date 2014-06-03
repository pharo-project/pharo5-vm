debug support
debugDrawPt: pt
	| canvas |
	canvas := Display getCanvas.
	canvas
		fillRectangle:((pt-2) corner: pt+2) color: Color red