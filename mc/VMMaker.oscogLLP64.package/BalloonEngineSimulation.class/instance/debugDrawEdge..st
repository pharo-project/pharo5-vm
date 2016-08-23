debug support
debugDrawEdge: edge
	self assert: (self isEdge: edge).
	(self isLine: edge) ifTrue:[^self debugDrawLine: edge].
	(self isBezier: edge) ifTrue:[^self debugDrawBezier: edge].
	self halt.