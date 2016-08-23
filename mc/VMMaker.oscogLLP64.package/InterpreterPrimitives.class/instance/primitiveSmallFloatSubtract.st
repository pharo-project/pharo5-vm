arithmetic float primitives
primitiveSmallFloatSubtract
	<option: #Spur64BitMemoryManager>
	| rcvr arg |
	<var: #rcvr type: #double>
	<var: #arg type: #double>

	rcvr := objectMemory smallFloatValueOf: (self stackValue: 1).
	arg := objectMemory loadFloatOrIntFrom: self stackTop.
	self successful ifTrue:
		[self pop: 2 thenPushFloat: rcvr - arg]