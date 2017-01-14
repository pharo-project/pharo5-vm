primitives-qwaq
primitiveEnableDrawRangeChecks
	"Primitive. Enable/disable draw (range) checks"
	| enabled |
	<export: true>
	interpreterProxy methodArgumentCount = 0 ifTrue:
		[interpreterProxy pop: 1.
		^interpreterProxy pushBool: doRangeChecks].
	interpreterProxy methodArgumentCount = 1 ifTrue:
		[enabled := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
		 interpreterProxy failed ifFalse:
			[doRangeChecks := enabled.
			^interpreterProxy pop: 1]]. "pop arg; return rcvr"
	^nil "keep compiler quiet"