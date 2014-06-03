shapes-compressed
loadCompressedSegment: segmentIndex from: points short: pointsShort leftFill: leftFill rightFill: rightFill lineWidth: lineWidth lineColor: lineFill 
	"Load the compressed segment identified by segment index"
	| x0 y0 x1 y1 x2 y2 index segs |
	<inline: true>

	"Check if have anything to do at all"
	(leftFill = rightFill and:[lineWidth = 0 or:[lineFill = 0]]) 
		ifTrue:[^nil]. "Nothing to do"

	index := segmentIndex * 6. "3 points with x/y each"
	pointsShort ifTrue:["Load short points"
		x0 := self loadPointShortAt: (index+0) from: points.
		y0 := self loadPointShortAt: (index+1) from: points.
		x1 := self loadPointShortAt: (index+2) from: points.
		y1 := self loadPointShortAt: (index+3) from: points.
		x2 := self loadPointShortAt: (index+4) from: points.
		y2 := self loadPointShortAt: (index+5) from: points.
	] ifFalse:[
		x0 := self loadPointIntAt: (index+0) from: points.
		y0 := self loadPointIntAt: (index+1) from: points.
		x1 := self loadPointIntAt: (index+2) from: points.
		y1 := self loadPointIntAt: (index+3) from: points.
		x2 := self loadPointIntAt: (index+4) from: points.
		y2 := self loadPointIntAt: (index+5) from: points.
	].
	"Briefly check if can represent the bezier as a line"
	((x0 = x1 and:[y0 = y1]) or:[x1 = x2 and:[y1 = y2]]) ifTrue:[
		"We can use a line from x0/y0 to x2/y2"
		(x0 = x2 and:[y0 = y2]) ifTrue:[^nil]. "Nothing to do"
		"Load and transform points"
		self point1Get at: 0 put: x0.
		self point1Get at: 1 put: y0.
		self point2Get at: 0 put: x2.
		self point2Get at: 1 put: y2.
		self transformPoints: 2.
		^self loadWideLine: lineWidth 
			from: self point1Get
			to: self point2Get
			lineFill: lineFill 
			leftFill: leftFill 
			rightFill: rightFill.
	].
	"Need bezier curve"
	"Load and transform points"
	self point1Get at: 0 put: x0.
	self point1Get at: 1 put: y0.
	self point2Get at: 0 put: x1.
	self point2Get at: 1 put: y1.
	self point3Get at: 0 put: x2.
	self point3Get at: 1 put: y2.
	self transformPoints: 3.
	segs := self loadAndSubdivideBezierFrom: self point1Get 
				via: self point2Get 
				to: self point3Get 
				isWide: (lineWidth ~= 0 and:[lineFill ~= 0]).
	engineStopped ifTrue:[^nil].
	self loadWideBezier: lineWidth lineFill: lineFill leftFill: leftFill rightFill: rightFill n: segs.
