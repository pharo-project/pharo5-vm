AET processing
findNextExternalUpdateFromAET
	"Check the active edge table for any entries that cannot be handled by the engine itself.
	If there are any, return true. Otherwise, step the the edge to the next y value."
	| edge count type |
	<inline: false>
	[self aetStartGet < self aetUsedGet] whileTrue:[
		edge := aetBuffer at: self aetStartGet.
		count := (self edgeNumLinesOf: edge) - 1.
		count = 0 ifTrue:[
			"Edge at end -- remove it"
			self removeFirstAETEntry
		] ifFalse:[
			"Store remaining lines back"
			self edgeNumLinesOf: edge put: count.
			type := self objectTypeOf: edge.
			(type bitAnd: GEPrimitiveWideMask) = GEPrimitiveEdge 
				ifTrue:[^true]. "This is an external edge"
			self dispatchOn: type in: EdgeStepTable.
			self resortFirstAETEntry.
			self aetStartPut: self aetStartGet+1.
		].
	].
	^false