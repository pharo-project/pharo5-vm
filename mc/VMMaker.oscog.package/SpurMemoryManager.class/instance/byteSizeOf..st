object access
byteSizeOf: oop
	<api>
	| format |
	(self isImmediate: oop) ifTrue: [^0].
	format := self formatOf: oop.
	format < self sixtyFourBitIndexableFormat ifTrue:
		[^(self numSlotsOf: oop) << self shiftForWord].
	format >= self firstByteFormat ifTrue:
		[^(self numSlotsOf: oop) << self shiftForWord - (format bitAnd: 7)].
	format >= self firstShortFormat ifTrue:
		[^(self numSlotsOf: oop) << self shiftForWord - ((format bitAnd: 3) << 1)].
	format >= self firstLongFormat ifTrue:
		[^(self numSlotsOf: oop) << self shiftForWord - ((format bitAnd: 1) << 2)].
	^(self numSlotsOf: oop) << self shiftForWord