object access
byteLengthOf: objOop 
	"Answer the number of indexable bytes in the given object.
	 Does not adjust contexts by stackPointer.
	 This is basically a special copy of lengthOf: for BitBlt. But it is also
	 whoorishly used for the Cogit."
	<api>
	| fmt numBytes |
	<inline: true>
	<asmLabel: false>
	fmt := self formatOf: objOop.
	numBytes := (self numSlotsOf: objOop) << self shiftForWord.
	fmt <= self sixtyFourBitIndexableFormat ifTrue:
		[^numBytes].
	fmt >= self firstByteFormat ifTrue: "bytes, including CompiledMethod"
		[^numBytes - (fmt bitAnd: 7)].
	fmt >= self firstShortFormat ifTrue:
		[^numBytes - ((fmt bitAnd: 3) << 1)].
	"fmt >= self firstLongFormat"
	^numBytes - ((fmt bitAnd: 1) << 2)