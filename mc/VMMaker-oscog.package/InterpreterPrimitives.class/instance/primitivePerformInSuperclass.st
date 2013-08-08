control primitives
primitivePerformInSuperclass
	| lookupClass rcvr currentClass |
	lookupClass := self stackTop.
	rcvr := self stackValue: 3.
	currentClass := objectMemory fetchClassOf: rcvr.
	[currentClass ~= lookupClass] whileTrue:
		[currentClass := self superclassOf: currentClass.
		 currentClass = objectMemory nilObject ifTrue: [^self primitiveFailFor: PrimErrBadArgument]].

	self primitiveObject: rcvr "a.k.a. self stackValue: 3"
		perform: (self stackValue: 2)
		withArguments: (self stackValue: 1)
		lookedUpIn: lookupClass "a.k.a. self stackTop"