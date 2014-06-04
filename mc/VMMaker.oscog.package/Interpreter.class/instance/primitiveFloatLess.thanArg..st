arithmetic float primitives
primitiveFloatLess: rcvrOop thanArg: argOop
	| rcvr arg |
	<var: #rcvr type: 'double '>
	<var: #arg type: 'double '>

	rcvr := self loadFloatOrIntFrom: rcvrOop.
	arg := self loadFloatOrIntFrom: argOop.
	successFlag ifTrue: [^ rcvr < arg].
