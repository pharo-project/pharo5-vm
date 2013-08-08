opcodes
branchAndLinkOpcodeWithOffset: aNumber
	
	| offset |
	offset := (aNumber - 8) asInteger.
	(offset between: -33554432 and: 33554428) ifFalse: [self error: 'The offset is to far. ARM does not support such far jumps.'].
	^ 16reb000000 bitOr: (offset >> 2 bitAnd: 16r00FFFFFF)
