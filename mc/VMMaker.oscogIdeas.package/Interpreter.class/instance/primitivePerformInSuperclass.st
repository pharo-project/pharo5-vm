control primitives
primitivePerformInSuperclass
	| lookupClass rcvr currentClass |
	lookupClass := self stackTop.
	rcvr := self stackValue: argumentCount.
	currentClass := self fetchClassOf: rcvr.
	[currentClass ~= lookupClass]
		whileTrue:
		[currentClass := self superclassOf: currentClass.
		currentClass = nilObj ifTrue: [^ self primitiveFail]].

	self popStack.
	self primitivePerformAt: lookupClass.
	successFlag ifFalse:
		[self push: lookupClass]