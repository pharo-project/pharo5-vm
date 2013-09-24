object access
numSlotsOf: objOop
	<returnTypeC: #usqInt>
	| halfHeader numSlots |
	self flag: #endianness.
	"numSlotsOf: should not be applied to free or forwarded objects."
	self assert: (self classIndexOf: objOop) > self isForwardedObjectClassIndexPun.
	halfHeader := self longAt: objOop + 4.
	numSlots := halfHeader >> self numSlotsHalfShift bitAnd: self numSlotsMask.
	^numSlots = self numSlotsMask
		ifTrue: [self longAt: objOop - self baseHeaderSize] "overflow slots; (2^32)-1 slots are plenty"
		ifFalse: [numSlots]