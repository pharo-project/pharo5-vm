GET processing
createGlobalEdgeTable
	"Create the global edge table"
	| object end |
	<inline: false>
	object := 0.
	end := objUsed.
	[object < end] whileTrue:[
		"Note: addEdgeToGET: may fail on insufficient space but that's not a problem here"
		(self isEdge: object) ifTrue:[
			"Check if the edge starts below fillMaxY."
			(self edgeYValueOf: object) >= self fillMaxYGet ifFalse:[
				self checkedAddEdgeToGET: object.
			].
		].
		object := object + (self objectLengthOf: object).
	].