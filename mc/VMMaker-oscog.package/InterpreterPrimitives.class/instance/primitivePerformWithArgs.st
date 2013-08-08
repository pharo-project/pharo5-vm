control primitives
primitivePerformWithArgs

	| lookupClass rcvr |
	rcvr := self stackValue: 2.
	lookupClass := objectMemory fetchClassOf: rcvr.

	self primitiveObject: rcvr "a.k.a. self stackValue: 2"
		perform: (self stackValue: 1)
		withArguments: self stackTop
		lookedUpIn: lookupClass