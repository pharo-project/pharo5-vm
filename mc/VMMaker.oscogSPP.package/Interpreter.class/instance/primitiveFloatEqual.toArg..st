arithmetic float primitives
primitiveFloatEqual: rcvrOop toArg: argOop
	| rcvr arg |
	<var: #rcvr type: 'double '>
	<var: #arg type: 'double '>

	rcvr := self loadFloatOrIntFrom: rcvrOop.
	arg := self loadFloatOrIntFrom: argOop.
	successFlag ifTrue: [^ rcvr = arg]