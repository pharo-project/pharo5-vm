bezier-loading
loadOval: lineWidth lineFill: lineFill leftFill: leftFill rightFill: rightFill
	"Load a rectangular oval currently defined by point1/point2"
	| w h cx cy nSegments |
	<inline: false>
	w := ((self point2Get at: 0) - (self point1Get at: 0)) // 2.
	h := ((self point2Get at: 1) - (self point1Get at: 1)) // 2.
	cx := ((self point2Get at: 0) + (self point1Get at: 0)) // 2.
	cy := ((self point2Get at: 1) + (self point1Get at: 1)) // 2.
	0 to: 15 do:[:i|
		self loadOvalSegment: i w: w h: h cx: cx cy: cy.
		self transformPoints: 3.
		nSegments := self loadAndSubdivideBezierFrom: self point1Get 
							via: self point2Get to: self point3Get
							isWide: (lineWidth ~= 0 and:[lineFill ~= 0]).
		engineStopped ifTrue:[^nil].
		self loadWideBezier: lineWidth lineFill: lineFill 
			leftFill: leftFill rightFill: rightFill n: nSegments.
		engineStopped ifTrue:[^nil].
	].