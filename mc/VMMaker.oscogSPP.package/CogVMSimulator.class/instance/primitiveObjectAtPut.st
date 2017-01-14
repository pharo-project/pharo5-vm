object access primitives
primitiveObjectAtPut
	| newValue |
	newValue := self stackValue: 0.
	((self stackValue: 1) = ConstOne
	 and: [(objectMemory isIntegerObject: newValue) not
		   or: [MULTIPLEBYTECODESETS not
			and: [(objectMemory integerValueOf: newValue) < 0]]]) ifTrue:
		[self halt].
	^super primitiveObjectAtPut