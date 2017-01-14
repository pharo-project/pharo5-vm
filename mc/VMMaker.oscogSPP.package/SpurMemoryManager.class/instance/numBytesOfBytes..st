object access
numBytesOfBytes: objOop 
	"Answer the number of indexable bytes in the given non-immediate byte-indexable object."
	| fmt |
	<inline: true>
	fmt := self formatOf: objOop.
	self assert: fmt >= self firstByteFormat.
	^(self numSlotsOf: objOop) << self shiftForWord - (fmt bitAnd: 7)