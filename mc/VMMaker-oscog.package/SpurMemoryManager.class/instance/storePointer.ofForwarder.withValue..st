heap management
storePointer: fieldIndex ofForwarder: objOop withValue: valuePointer

	self assert: (self isForwarded: objOop).
	self assert: (self isOopForwarded: valuePointer) not.

	(self isYoung: objOop) ifFalse: "most stores into young objects"
		[((self isNonImmediate: valuePointer) and: [self isYoung: valuePointer]) ifTrue:
			[self possibleRootStoreInto: objOop]].

	^self
		longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)
		put: valuePointer