object access
numSlotsOf: objOop
	<returnTypeC: #usqInt>
	<api>
	| numSlots |
	self flag: #endianness.
	"numSlotsOf: should not be applied to free or forwarded objects."
	self assert: (self classIndexOf: objOop) > self isForwardedObjectClassIndexPun.
	numSlots := self rawNumSlotsOf: objOop.
	^numSlots = self numSlotsMask	"overflow slots; (2^32)-1 slots are plenty"
		ifTrue: [self rawOverflowSlotsOf: objOop]
		ifFalse: [numSlots]