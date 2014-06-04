primitives-rendering
loadRenderingState
	"Load the entire state from the interpreter for the rendering primitives.
	 Answer 0 on success or a non-zero failure code on failure."
	| failCode edgeOop fillOop state |
	<inline: false>
	interpreterProxy methodArgumentCount = 2
		ifFalse:[^PrimErrBadNumArgs].

	(failCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 2)) ~= 0 ifTrue:
		[^failCode].

	fillOop := interpreterProxy stackObjectValue: 0.
	edgeOop := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue: [^PrimErrBadArgument].

	"Load span buffer and bitBlt"
	(failCode := self loadSpanBufferFrom:
		(interpreterProxy fetchPointer: BESpanIndex ofObject: engine)) = 0 ifFalse:
		[^failCode].
	(self loadBitBltFrom: 
		(interpreterProxy fetchPointer: BEBitBltIndex ofObject: engine)) ifFalse:
		[^GEFBitBltLoadFailed].
	(self loadFormsFrom:
		(interpreterProxy fetchPointer: BEFormsIndex ofObject: engine)) ifFalse:
		[^GEFFormLoadFailed].
	"Check edgeOop and fillOop"
	(interpreterProxy slotSizeOf: edgeOop) < ETBalloonEdgeDataSize 
		ifTrue:[^GEFEdgeDataTooSmall].
	(interpreterProxy slotSizeOf: fillOop) < FTBalloonFillDataSize 
		ifTrue:[^GEFFillDataTooSmall].

	"Note: Rendering can only take place if we're not in one of the intermediate
	(e.g., external) states."
	state := self stateGet.
	(state = GEStateWaitingForEdge or:[
		state = GEStateWaitingForFill or:[
			state = GEStateWaitingChange]]) ifTrue:[^GEFWrongState].

	^0