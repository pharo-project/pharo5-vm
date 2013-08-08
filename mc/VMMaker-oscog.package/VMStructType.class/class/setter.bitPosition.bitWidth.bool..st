code generation
setter: getter bitPosition: bitPosition bitWidth: bitWidth bool: isBool
	^String streamContents:
		[:s| | startByte endByte shift alignedPowerOf2 accessor mask expr |
		startByte := bitPosition // 8.
		endByte := bitPosition + bitWidth - 1 // 8.
		shift := bitPosition \\ 8.
		alignedPowerOf2 := (#(8 16 32 64) includes: bitWidth) and: [shift = 0].
		accessor := 'unsigned'
					, (#('Byte' 'Short' 'Long' 'Long')
							at: endByte - startByte + 1
							ifAbsent: ['LongLong'])
					, 'At: address + '.
		mask := #(16rFF 16rFFFF 16rFFFFFFFF 16rFFFFFFFF)
						at: endByte - startByte + 1
						ifAbsent: [(2 raisedTo: 64) - 1].
		s nextPutAll: getter; nextPutAll: ': aValue'.
		(isBool or: [alignedPowerOf2]) ifFalse:
			[s crtab: 1; nextPutAll: 'self assert: (aValue between: 0 and: '; nextPutAll:  ((1 << bitWidth) - 1) hex; nextPutAll: ').'].
		s crtab: 1.
		alignedPowerOf2 ifTrue:
			[s nextPut: $^].
		s nextPutAll: 'memory';
		  crtab: 2; nextPutAll: accessor; print: startByte + 1;
		  crtab: 2; nextPutAll: 'put: '.
		isBool ifTrue:
			[s nextPut: $(].
		alignedPowerOf2 ifFalse:
			[s nextPutAll: '((memory '; nextPutAll: accessor; print: startByte + 1;
			    nextPutAll: ') bitAnd: '; nextPutAll: (mask - ((1 << bitWidth - 1) << shift)) hex;
			    nextPutAll: ') + '].
		expr := isBool ifTrue: ['(aValue ifTrue: [1] ifFalse: [0])'] ifFalse: ['aValue'].
		shift = 0
			ifTrue:
				[s nextPutAll: expr]
			ifFalse:
				[s nextPut: $(; nextPutAll: expr; nextPutAll: ' bitShift: '; print: shift; nextPut: $)].
		isBool ifTrue:
			[s nextPut: $)].
		alignedPowerOf2 ifFalse:
			[s nextPut: $.; crtab: 1; nextPutAll: '^aValue']]