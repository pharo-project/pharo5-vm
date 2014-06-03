shapes-polygons
loadPolygon: points nPoints: nPoints fill: fillIndex lineWidth: lineWidth lineFill: lineFill pointsShort: isShort
	| x0 y0 x1 y1 |
	<var:#points type:'int *'>
	isShort ifTrue:[
		x0 := self loadPointShortAt: 0 from: points.
		y0 := self loadPointShortAt: 1 from: points.
	] ifFalse:[
		x0 := self loadPointIntAt: 0 from: points.
		y0 := self loadPointIntAt: 1 from: points.
	].
	1 to: nPoints-1 do:[:i|
		isShort ifTrue:[
			x1 := self loadPointShortAt: i*2 from: points.
			y1 := self loadPointShortAt: i*2+1 from: points.
		] ifFalse:[
			x1 := self loadPointIntAt: i*2 from: points.
			y1 := self loadPointIntAt: i*2+1 from: points.
		].
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