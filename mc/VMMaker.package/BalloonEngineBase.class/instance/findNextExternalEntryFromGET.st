GET processing
findNextExternalEntryFromGET
	"Check the global edge table for any entries that cannot be handled by the engine itself.
	If there are any, return true. Otherwise, initialize the the edge and add it to the AET"
	| yValue edge type |
	yValue := self currentYGet.
	"As long as we have entries in the GET"
	[self getStartGet < self getUsedGet] whileTrue:[
		edge := getBuffer at: self getStartGet.
		(self edgeYValueOf: edge) > yValue ifTrue:[^false]. "No more edges to add"
		type := self objectTypeOf: edge.
		(type bitAnd: GEPrimitiveWideMask) = GEPrimitiveEdge 
			ifTrue:[^true]. "This is an external edge"
		"Note: We must make sure not to do anything with the edge if there is not
		enough room in the AET"
		(self needAvailableSpace: 1) ifFalse:[^false]. "No more room"
		"Process the edge in the engine itself"
		self dispatchOn: type in: EdgeInitTable.
		"Insert the edge into the AET"
		self insertEdgeIntoAET: edge.
		self getStartPut: self getStartGet + 1.
	].
	"No entries in GET"
	^false