object access
numSlotsOfAny: objOop
	"A private internal version of numSlotsOf: that is happy to be applied to free or forwarded objects."
	<returnTypeC: #usqInt>
	| halfHeader numSlots |
	self flag: #endianness.
	halfHeader := self longAt: objOop + 4.
	numSlots := halfHeader >> self numSlotsHalfShift bitAnd: self numSlotsMask.
	^numSlots = self numSlotsMask
		ifTrue: [self longAt: objOop - self baseHeaderSize] "overflow slots; (2^32)-1 slots are plenty"
		ifFalse: [numSlots]