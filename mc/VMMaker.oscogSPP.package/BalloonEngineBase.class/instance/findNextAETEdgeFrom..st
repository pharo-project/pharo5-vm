AET processing
findNextAETEdgeFrom: leftEdge
	| depth rightEdge |
	depth := self edgeZValueOf: leftEdge.
	[self aetStartGet < self aetUsedGet] whileTrue:[
		rightEdge := aetBuffer at: self aetStartGet.
		(self edgeZValueOf: rightEdge) >= depth ifTrue:[^rightEdge].
		self aetStartPut: self aetStartGet + 1.
	].
	^nil