comparison float primitives
primitiveFloatLess: rcvrOop thanArg: argOop
	| rcvr arg |
	<var: #rcvr type: #double>
	<var: #arg type: #double>

	rcvr := objectMemory loadFloatOrIntFrom: rcvrOop.
	arg := objectMemory loadFloatOrIntFrom: argOop.
	^rcvr < arg