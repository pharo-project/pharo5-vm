indexing primitives
primitiveFloatAt
	"Provide platform-independent access to 32-bit words comprising
	 a Float.  Map index 1 onto the most significant word and index 2
	 onto the least significant word."
	| rcvr index result |
	<var: #result type: #usqInt>
	rcvr := self stackValue: 1.
	index := self stackTop.
	index = ConstOne ifTrue:
		[result := self positive32BitIntegerFor:
					(objectMemory
						fetchLong32: (VMBIGENDIAN ifTrue: [0] ifFalse: [1])
						ofFloatObject: rcvr).
		^self pop: 2 thenPush: result].
	index = ConstTwo ifTrue:
		[result := self positive32BitIntegerFor:
					(objectMemory
						fetchLong32: (VMBIGENDIAN ifTrue: [1] ifFalse: [0])
						ofFloatObject: rcvr).
		^self pop: 2 thenPush: result].
	self primitiveFailFor: ((objectMemory isIntegerObject: index)
							ifTrue: [PrimErrBadIndex]
							ifFalse: [PrimErrBadArgument])