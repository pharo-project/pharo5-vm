shapes-polygons
loadArrayPolygon: points nPoints: nPoints fill: fillIndex lineWidth: lineWidth lineFill: lineFill
	| x0 y0 x1 y1 |
	self loadPoint: self point1Get from: (interpreterProxy fetchPointer: 0 ofObject: points).
	interpreterProxy failed ifTrue:[^nil].
	x0 := self point1Get at: 0.
	y0 := self point1Get at: 1.
	1 to: nPoints-1 do:[:i|
		self loadPoint: self point1Get from: (interpreterProxy fetchPointer: i ofObject: points).
		interpreterProxy failed ifTrue:[^nil].
		x1 := self point1Get at: 0.
		y1 := self point1Get at: 1.
		self point1Get at: 0 put: x0.
		self point1Get at: 1 put: y0.
		self point2Get at: 0 put: x1.
		self point2Get at: 1 put: y1.
		self transformPoints: 2.
		self loadWideLine: lineWidth 
			from: self point1Get
			to: self point2Get
			lineFill: lineFill 
			leftFill: fillIndex
			rightFill: 0.
		engineStopped ifTrue:[^nil].
		x0 := x1.
		y0 := y1.
	].