control primitives
primitivePerformInSuperclass
	| lookupClass rcvr currentClass |
	rcvr := self stackValue: 3.
	lookupClass := self stackTop.
	(argumentCount > 3 "e.g. object:perform:withArguments:inClass:"
	 and: [objectMemory isOopForwarded: rcvr]) ifTrue:
		[^self primitiveFail].
	currentClass := objectMemory fetchClassOf: rcvr.
	[currentClass ~= lookupClass] whileTrue:
		[currentClass := self superclassOf: currentClass.
		 currentClass = objectMemory nilObject ifTrue:
			[^self primitiveFailFor: PrimErrBadArgument]].

	self primitiveObject: rcvr "a.k.a. self stackValue: 3"
		perform: (self stackValue: 2)
		withArguments: (self stackValue: 1)
		lookedUpIn: lookupClass "a.k.a. self stackTop"