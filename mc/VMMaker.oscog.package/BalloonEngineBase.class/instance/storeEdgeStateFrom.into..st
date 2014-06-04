storing state
storeEdgeStateFrom: edge into: edgeOop

	<inline: false>
	(interpreterProxy slotSizeOf: edgeOop) < ETBalloonEdgeDataSize 
		ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy storeInteger: ETIndexIndex ofObject: edgeOop withValue: 
		(self objectIndexOf: edge).
	interpreterProxy storeInteger: ETXValueIndex ofObject: edgeOop withValue: 
		(self edgeXValueOf: edge).
	interpreterProxy storeInteger: ETYValueIndex ofObject: edgeOop withValue: 
		(self currentYGet).
	interpreterProxy storeInteger: ETZValueIndex ofObject: edgeOop withValue: 
		(self edgeZValueOf: edge).
	interpreterProxy storeInteger: ETLinesIndex ofObject: edgeOop withValue: 
		(self edgeNumLinesOf: edge).
	self lastExportedEdgePut: edge.