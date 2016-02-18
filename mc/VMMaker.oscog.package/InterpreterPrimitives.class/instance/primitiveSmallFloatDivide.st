arithmetic float primitives
primitiveSmallFloatDivide
	<option: #Spur64BitMemoryManager>
	| rcvr arg |
	<var: #rcvr type: #double>
	<var: #arg type: #double>

	rcvr := objectMemory smallFloatValueOf: (self stackValue: 1).
	arg := objectMemory loadFloatOrIntFrom: self stackTop.
	arg = 0.0 ifTrue:
		[self primitiveFail].
	self successful ifTrue:
		[self pop: 2 thenPushFloat: rcvr / arg]