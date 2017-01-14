debug support
debugDrawBezier: line
	| canvas p1 p2 p3 |
	self assert:(self isBezier: line).
	p1 := (self edgeXValueOf: line) @ (self edgeYValueOf: line) // self aaLevelGet.
	p2 := (self bezierViaXOf: line) @ (self bezierViaYOf: line) // self aaLevelGet.
	p3 := (self bezierEndXOf: line) @ (self bezierEndYOf: line) // self aaLevelGet.
	canvas := Display getCanvas.
	canvas
		line: p1 to: p2 width: 2 color: Color blue;
		line: p2 to: p3 width: 2 color: Color blue.