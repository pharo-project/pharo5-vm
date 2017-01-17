object access
numSlotsOfAny: objOop
	"A private internal version of numSlotsOf: that is happy to be applied to free or forwarded objects."
	<returnTypeC: #usqInt>
	| numSlots |
	numSlots := self rawNumSlotsOf: objOop.
	^numSlots = self numSlotsMask
		ifTrue: [self rawOverflowSlotsOf: objOop] "overflow slots; (2^32)-1 slots are plenty"
		ifFalse: [numSlots]