arithmetic float primitives
primitiveFloatDivide: rcvrOop byArg: argOop
	| rcvr arg |
	<var: #rcvr type: 'double '>
	<var: #arg type: 'double '>

	rcvr := self loadFloatOrIntFrom: rcvrOop.
	arg := self loadFloatOrIntFrom: argOop.
	self successful ifTrue: [
		self success: arg ~= 0.0.
		self successful ifTrue: [
			self pop: 2.
			self pushFloat: (self cCode: 'rcvr / arg' inSmalltalk: [rcvr / arg])]].