arithmetic float primitives
primitiveSmallFloatLessThan
	<option: #Spur64BitMemoryManager>
	| rcvr arg |
	<var: #rcvr type: #double>
	<var: #arg type: #double>

	rcvr := objectMemory smallFloatValueOf: (self stackValue: 1).
	arg := objectMemory loadFloatOrIntFrom: self stackTop.
	self successful ifTrue:
		[self pop: 2 thenPushBool: rcvr < arg]