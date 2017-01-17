primitives
primitiveGetBezierStats
	| failureCode statOop stats |
	<export: true>
	<inline: false>
	<var: #stats type:'int *'>

	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	statOop := interpreterProxy stackObjectValue: 0.
	(interpreterProxy failed not
	and: [(interpreterProxy isWords: statOop)
	and: [(interpreterProxy slotSizeOf: statOop) >= 4]])
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	stats := interpreterProxy firstIndexableField: statOop.
	stats at: 0 put: (stats at: 0) + (workBuffer at: GWBezierMonotonSubdivisions).
	stats at: 1 put: (stats at: 1) + (workBuffer at: GWBezierHeightSubdivisions).
	stats at: 2 put: (stats at: 2) + (workBuffer at: GWBezierOverflowSubdivisions).
	stats at: 3 put: (stats at: 3) + (workBuffer at: GWBezierLineConversions).

	interpreterProxy pop: 1. "Leave rcvr on stack"