primitives-access
primitiveGetCounts
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
	and: [(interpreterProxy slotSizeOf: statOop) >= 9]])
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	stats := interpreterProxy firstIndexableField: statOop.
	stats at: 0 put: (stats at: 0) + (workBuffer at: GWCountInitializing).
	stats at: 1 put: (stats at: 1) + (workBuffer at: GWCountFinishTest).
	stats at: 2 put: (stats at: 2) + (workBuffer at: GWCountNextGETEntry).
	stats at: 3 put: (stats at: 3) + (workBuffer at: GWCountAddAETEntry).
	stats at: 4 put: (stats at: 4) + (workBuffer at: GWCountNextFillEntry).
	stats at: 5 put: (stats at: 5) + (workBuffer at: GWCountMergeFill).
	stats at: 6 put: (stats at: 6) + (workBuffer at: GWCountDisplaySpan).
	stats at: 7 put: (stats at: 7) + (workBuffer at: GWCountNextAETEntry).
	stats at: 8 put: (stats at: 8) + (workBuffer at: GWCountChangeAETEntry).

	interpreterProxy pop: 1. "Leave rcvr on stack"