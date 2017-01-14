AET processing
findNextExternalFillFromAET
	"Scan the active edge table. If there is any fill that cannot be handled by the engine itself,  return true. Otherwise handle the fills and return false."
	| leftEdge rightEdge leftX rightX |
"self currentYGet >= 680 ifTrue:[
self printAET.
self halt.
]."

	<inline: false>
	leftX := rightX := self fillMaxXGet.
	[self aetStartGet < self aetUsedGet] whileTrue:[
		leftEdge := rightEdge := aetBuffer at: self aetStartGet.
		"TODO: We should check if leftX from last operation 
			is  greater than leftX from next edge.
			Currently, we rely here on spanEndAA
			from the span buffer fill."
		leftX := rightX := self edgeXValueOf: leftEdge.
		leftX >= self fillMaxXGet ifTrue:[^false]. "Nothing more visible"
		self quickRemoveInvalidFillsAt: leftX.
		"Check if we need to draw the edge"
		(self isWide: leftEdge) ifTrue:[
			self toggleWideFillOf: leftEdge.
			"leftX := rightX := self drawWideEdge: leftEdge from: leftX."
		].
		(self areEdgeFillsValid: leftEdge) ifTrue:[
			self toggleFillsOf: leftEdge. "Adjust the fills"
			engineStopped ifTrue:[^false].
		].
		self aetStartPut: self aetStartGet + 1.
		self aetStartGet < self aetUsedGet ifTrue:[
			rightEdge := aetBuffer at: self aetStartGet.
			rightX := self edgeXValueOf: rightEdge.
			rightX >= self fillMinXGet ifTrue:["This is the visible portion"
				self fillAllFrom: leftX to: rightX.
				"Fetch the currently active fill"
				"fill := self makeUnsignedFrom: self topFill.
				fill = 0 ifFalse:[self fillSpan: fill from: leftX to: rightX max: self topRightX]"
			].
		].
	].
	"Note: Due to pre-clipping we may have to draw remaining stuff with the last fill"
	rightX < self fillMaxXGet ifTrue:[
		self fillAllFrom: rightX to: self fillMaxXGet.
		"fill := self makeUnsignedFrom: self topFill.
		fill = 0 ifFalse:[self fillSpan: fill from: rightX to: self fillMaxXGet max: self topRightX]."
	].
	^false