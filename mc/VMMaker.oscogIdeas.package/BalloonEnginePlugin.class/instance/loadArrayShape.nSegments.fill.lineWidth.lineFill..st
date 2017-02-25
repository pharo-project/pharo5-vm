shapes-polygons
loadArrayShape: points nSegments: nSegments fill: fillIndex lineWidth: lineWidth lineFill: lineFill 
	| pointOop x0 y0 x1 y1 x2 y2 segs |
	<inline: false>
	0 to: nSegments-1 do:[:i|
		pointOop := interpreterProxy fetchPointer: (i * 3) ofObject: points.
		self loadPoint: self point1Get from: pointOop.
		pointOop := interpreterProxy fetchPointer: (i * 3 + 1) ofObject: points.
		self loadPoint: self point2Get from: pointOop.
		pointOop := interpreterProxy fetchPointer: (i * 3 + 2) ofObject: points.
		self loadPoint: self point3Get from: pointOop.
		interpreterProxy failed ifTrue:[^nil].
		self transformPoints: 3.
		x0 := self point1Get at: 0.
		y0 := self point1Get at: 1.
		x1 := self point2Get at: 0.
		y1 := self point2Get at: 1.
		x2 := self point3Get at: 0.
		y2 := self point3Get at: 1.
		"Check if we can use a line"
		((x0 = y0 and:[x1 = y1]) or:[x1 = x2 and:[y1 = y2]]) ifTrue:[
			self loadWideLine: lineWidth
				from: self point1Get
				to: self point3Get
				lineFill: lineFill
				leftFill: fillIndex
				rightFill: 0.
		] ifFalse:["Need bezier"
			segs := self loadAndSubdivideBezierFrom: self point1Get
					via: self point2Get
					to: self point3Get
					isWide: (lineWidth ~= 0 and:[lineFill ~= 0]).
			engineStopped ifTrue:[^nil].
			self loadWideBezier: lineWidth
				lineFill: lineFill
				leftFill: fillIndex
				rightFill: 0
				n: segs.
		].
		engineStopped ifTrue:[^nil].
	].