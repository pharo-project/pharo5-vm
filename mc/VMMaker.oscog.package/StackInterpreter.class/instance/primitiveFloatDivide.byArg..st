arithmetic float primitives
primitiveFloatDivide: rcvrOop byArg: argOop
	| rcvr arg |
	<var: #rcvr type: #double>
	<var: #arg type: #double>

	rcvr := objectMemory loadFloatOrIntFrom: rcvrOop.
	arg := objectMemory loadFloatOrIntFrom: argOop.
	self success: arg ~= 0.0.
	self successful ifTrue:
		[self pop: 2 thenPushFloat: rcvr / arg]