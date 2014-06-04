object enumeration
addressAfter: objOop
	"Answer the address immediately following an object."
	| numSlots slotBytes |
	numSlots := self numSlotsOfAny: objOop.
	slotBytes := numSlots = 0
					ifTrue: [self allocationUnit]
					ifFalse: [numSlots << self shiftForWord].
	^objOop + self baseHeaderSize + slotBytes