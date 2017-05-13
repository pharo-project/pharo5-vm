object enumeration
addressAfter: objOop
	"Answer the address immediately following an object."
	<returnTypeC: #usqInt>
	| numSlots |
	numSlots := self rawNumSlotsOf: objOop.
	numSlots = 0 ifTrue: [^objOop + self allocationUnit + self baseHeaderSize].
	numSlots = self numSlotsMask ifTrue:
		[numSlots := self rawOverflowSlotsOf: objOop].
	^objOop + self baseHeaderSize + (numSlots + (numSlots bitAnd: 1) << self shiftForWord)