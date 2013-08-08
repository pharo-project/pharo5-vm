bezier-loading
loadBezier: bezier segment: index leftFill: leftFillIndex rightFill: rightFillIndex offset: yOffset
	"Initialize the bezier segment stored on the stack"
	<inline: false>
	(self bzEndY: index) >= (self bzStartY: index) ifTrue:[
		"Top to bottom"
		self edgeXValueOf: bezier put: (self bzStartX: index).
		self edgeYValueOf: bezier put: (self bzStartY: index) - yOffset.
		self bezierViaXOf: bezier put: (self bzViaX: index).
		self bezierViaYOf: bezier put: (self bzViaY: index) - yOffset.
		self bezierEndXOf: bezier put: (self bzEndX: index).
		self bezierEndYOf: bezier put: (self bzEndY: index) - yOffset.
	] ifFalse:[
		self edgeXValueOf: bezier put: (self bzEndX: index).
		self edgeYValueOf: bezier put: (self bzEndY: index) - yOffset.
		self bezierViaXOf: bezier put: (self bzViaX: index).
		self bezierViaYOf: bezier put: (self bzViaY: index) - yOffset.
		self bezierEndXOf: bezier put: (self bzStartX: index).
		self bezierEndYOf: bezier put: (self bzStartY: index) - yOffset.
	].
	self edgeZValueOf: bezier put: self currentZGet.
	self edgeLeftFillOf: bezier put: leftFillIndex.
	self edgeRightFillOf: bezier put: rightFillIndex.
	"self debugDrawBezier: bezier."