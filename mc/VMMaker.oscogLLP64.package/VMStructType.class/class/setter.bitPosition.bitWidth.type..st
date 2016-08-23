code generation
setter: getter bitPosition: bitPosition bitWidth: bitWidth type: typeOrNil
	^String streamContents:
		[:s| | startByte endByte shift alignedPowerOf2 accessor mask expr |
		startByte := bitPosition // 8.
		endByte := bitPosition + bitWidth - 1 // 8.
		shift := bitPosition \\ 8.
		alignedPowerOf2 := (#(8 16 32 64) includes: bitWidth) and: [shift = 0].
		accessor := 'unsigned'
					, (#('Byte' 'Short' 'Long' 'Long')
							at: endByte - startByte + 1
							ifAbsent: ['Long64'])
					, 'At: address + '.
		(self offsetForInstVar: getter) ifNotNil:
			[:offsetExpr| accessor := accessor, offsetExpr, ' + '].
		mask := #(16rFF 16rFFFF 16rFFFFFFFF 16rFFFFFFFF)
						at: endByte - startByte + 1
						ifAbsent: [(2 raisedTo: 64) - 1].
		s nextPutAll: getter; nextPutAll: ': aValue'.
		(typeOrNil notNil or: [alignedPowerOf2]) ifFalse:
			[s crtab: 1; nextPutAll: 'self assert: (aValue between: 0 and: '; nextPutAll:  ((1 << bitWidth) - 1) hex; nextPutAll: ').'].
		s crtab: 1.
		alignedPowerOf2 ifTrue:
			[s nextPut: $^].
		s nextPutAll: 'memory';
		  crtab: 2; nextPutAll: accessor; print: startByte + 1.
		s crtab: 2; nextPutAll: 'put: '.
		typeOrNil ifNotNil:
			[s nextPut: $(].
		alignedPowerOf2 ifFalse:
			[s nextPutAll: '((memory '; nextPutAll: accessor; print: startByte + 1;
			    nextPutAll: ') bitAnd: '; nextPutAll: (mask - ((1 << bitWidth - 1) << shift)) hex;
			    nextPutAll: ') + '].
		expr := typeOrNil caseOf: {
						[nil] -> ['aValue'].
						[#Boolean] -> ['(aValue ifTrue: [1] ifFalse: [0])'] }
					otherwise: ['(aValue ifNotNil: [aValue asUnsignedInteger] ifNil: [0])'].
		shift = 0
			ifTrue:
				[s nextPutAll: expr]
			ifFalse:
				[s nextPut: $(; nextPutAll: expr; nextPutAll: ' bitShift: '; print: shift; nextPut: $)].
		typeOrNil notNil ifTrue:
			[s nextPut: $)].
		alignedPowerOf2 ifFalse:
			[s nextPut: $.; crtab: 1; nextPutAll: '^aValue']]