arithmetic float primitives
primitiveFloatSubtract: rcvrOop fromArg: argOop
	| rcvr arg |
	<var: #rcvr type: 'double '>
	<var: #arg type: 'double '>

	rcvr := self loadFloatOrIntFrom: rcvrOop.
	arg := self loadFloatOrIntFrom: argOop.
	successFlag ifTrue: [
		self pop: 2.
		self pushFloat: rcvr - arg].