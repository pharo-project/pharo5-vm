allocation
numSlotsForShortening: objOop toIndexableSize: indexableSize
	<inline: true>
	^(self formatOf: objOop) caseOf:
		{ [self arrayFormat]			-> [indexableSize].
		  [self firstLongFormat]		-> [self numSlotsForBytes: indexableSize * 4].
		  [self firstLongFormat + 1]	-> [self numSlotsForBytes: indexableSize * 4] }