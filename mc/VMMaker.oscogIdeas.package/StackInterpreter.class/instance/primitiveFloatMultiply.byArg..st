arithmetic float primitives
primitiveFloatMultiply: rcvrOop byArg: argOop
	| rcvr arg |
	<var: #rcvr type: #double>
	<var: #arg type: #double>

	rcvr := objectMemory loadFloatOrIntFrom: rcvrOop.
	arg := objectMemory loadFloatOrIntFrom: argOop.
	self successful ifTrue:
		[self pop: 2 thenPushFloat: rcvr * arg]