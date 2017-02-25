method map
subMethodsAsRangesFor: surrogateOrAddress
	<doNotGenerate>
	| cogMethod codeRanges |
	cogMethod := surrogateOrAddress isInteger
								ifTrue: [self cogMethodSurrogateAt: surrogateOrAddress]
								ifFalse: [surrogateOrAddress].
	^cogMethod cmType = CMMethod ifTrue:
		[codeRanges := self codeRangesFor: cogMethod.
		 ^codeRanges size > 1 "omit the block dispatch range"
			ifTrue: [codeRanges allButLast]
			ifFalse: [codeRanges]]