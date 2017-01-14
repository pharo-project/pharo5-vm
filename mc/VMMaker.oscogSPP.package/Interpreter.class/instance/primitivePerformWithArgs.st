control primitives
primitivePerformWithArgs

	| lookupClass rcvr |
	rcvr := self stackValue: argumentCount.
	lookupClass := self fetchClassOf: rcvr.
	self primitivePerformAt: lookupClass.
