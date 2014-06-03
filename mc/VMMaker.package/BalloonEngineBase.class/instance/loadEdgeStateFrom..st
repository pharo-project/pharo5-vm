loading state
loadEdgeStateFrom: edgeOop
	| edge |
	<inline: false>
	edge := self lastExportedEdgeGet.
	(interpreterProxy slotSizeOf: edgeOop) < ETBalloonEdgeDataSize 
		ifTrue:[^nil].
	self edgeXValueOf: edge 
		put: (interpreterProxy fetchInteger: ETXValueIndex ofObject: edgeOop).
	self edgeYValueOf: edge 
		put: (interpreterProxy fetchInteger: ETYValueIndex ofObject: edgeOop).
	self edgeZValueOf: edge 
		put: (interpreterProxy fetchInteger: ETZValueIndex ofObject: edgeOop).
	self edgeNumLinesOf: edge 
		put: (interpreterProxy fetchInteger: ETLinesIndex ofObject: edgeOop).
	^edge