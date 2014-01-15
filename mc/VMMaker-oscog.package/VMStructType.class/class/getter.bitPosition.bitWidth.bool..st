code generation
getter: getter bitPosition: bitPosition bitWidth: bitWidth bool: isBool
	^String streamContents:
		[:s| | startByte endByte alignedPowerOf2 shift bool |
		startByte := bitPosition // 8.
		endByte := bitPosition + bitWidth - 1 // 8.
		shift := bitPosition \\ 8.
		alignedPowerOf2 := (#(8 16 32 64) includes: bitWidth) and: [shift = 0].
		s nextPutAll: getter; crtab: 1; nextPut: $^.
		isBool ifTrue:
			[s nextPut: $(].
		alignedPowerOf2 ifFalse:
			[s nextPut: $(].
		shift ~= 0 ifTrue:
			[s nextPut: $(].
		s nextPutAll: 'memory unsigned';
		   nextPutAll: (#('Byte' 'Short' 'Long' 'Long')
							at: endByte - startByte + 1
							ifAbsent: ['LongLong']);
		  nextPutAll: 'At: address + '; print: startByte + 1.
		shift ~= 0 ifTrue:
			[s nextPutAll: ') bitShift: -'; print: shift].
		alignedPowerOf2 ifFalse:
			[s nextPutAll: ') bitAnd: '; nextPutAll: ((1 << bitWidth) - 1) hex].
		isBool ifTrue:
			[s nextPutAll: ') ~= 0']]