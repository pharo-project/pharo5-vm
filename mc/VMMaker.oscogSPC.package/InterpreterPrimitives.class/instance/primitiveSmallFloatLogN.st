arithmetic float primitives
primitiveSmallFloatLogN
	"Natural log."
	<option: #Spur64BitMemoryManager>
	| rcvr |
	<var: #rcvr type: #double>
	rcvr := objectMemory smallFloatValueOf: self stackTop.
	self pop: 1
		thenPushFloat: (self cCode: [rcvr log]
							inSmalltalk: [rcvr = rcvr
											ifTrue: [rcvr ln]
											ifFalse: [Float nan]])