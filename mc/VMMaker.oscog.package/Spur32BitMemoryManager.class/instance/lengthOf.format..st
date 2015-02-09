object access
lengthOf: objOop format: fmt
	"Answer the number of indexable units in the given object.
	 For a CompiledMethod, the size of the method header (in bytes)
	 should be subtracted from the result of this method."
	| numSlots |
	<inline: true>
	numSlots := self numSlotsOfAny: objOop. "don't let forwarders freak us out..."
	fmt <= self ephemeronFormat ifTrue:
		[^numSlots].
	fmt >= self firstByteFormat ifTrue: "bytes, including CompiledMethod"
		[^numSlots << self shiftForWord - (fmt bitAnd: 7)].
	fmt >= self firstShortFormat ifTrue:
		[^numSlots << (self shiftForWord - 1) - (fmt bitAnd: 3)].
	fmt >= self firstLongFormat ifTrue:
		[^numSlots << (self shiftForWord - 2) - (fmt bitAnd: 1)].
	fmt = self sixtyFourBitIndexableFormat ifTrue:
		[^numSlots >> 1].
	"fmt = self forwardedFormat"
	^0