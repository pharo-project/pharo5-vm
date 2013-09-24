object access
storePointer: fieldIndex ofObject: objOop withValue: valuePointer
	"Note must check here for stores of young objects into old ones."
	self assert: (self isForwarded: objOop) not.

	(self isYoung: objOop) ifFalse: "most stores into young objects"
		[(self isImmediate: valuePointer) ifFalse:
			[(self isYoung: valuePointer) ifTrue:
				[self possibleRootStoreInto: objOop]]].

	^self
		longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)
		put: valuePointer