testing
shouldUseLongAccessForInstVarOffset: offset
	"compute the mask of which inst var offsets need to be negated.
	 This is true of inst vars of contexts only."
	shouldNegateInstVarOffsetsMask ifNotNil:
		[:snivo| ^(snivo bitAnd: (1 bitShift: offset)) ~= 0].
	"The order in which this is done means that if the first offset is +ve all others will be too."
	shouldNegateInstVarOffsetsMask := 0.
	code methodClass instVarNamesAndOffsetsDo:
		[:n :o|
		o >= 0 ifTrue:
			[^(shouldNegateInstVarOffsetsMask bitAnd: (1 bitShift: offset)) ~= 0].
		o < 0 ifTrue:
			[shouldNegateInstVarOffsetsMask := shouldNegateInstVarOffsetsMask + (1 bitShift: -1 - o)]].
	^true