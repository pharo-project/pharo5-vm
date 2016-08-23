code generation
getter: getter bitPosition: bitPosition bitWidth: bitWidth type: typeOrNil
	^String streamContents:
		[:s| | startByte endByte alignedPowerOf2 shift |
		startByte := bitPosition // 8.
		endByte := bitPosition + bitWidth - 1 // 8.
		shift := bitPosition \\ 8.
		alignedPowerOf2 := (#(8 16 32 64) includes: bitWidth) and: [shift = 0].
		s nextPutAll: getter; crtab: 1.
		(typeOrNil notNil and: [typeOrNil last = $*]) ifTrue:
			[s nextPutAll: '| v |'; crtab: 1].
		s nextPut: $^.
		typeOrNil ifNotNil:
			[s nextPut: $(.
			 typeOrNil last = $* ifTrue:
				[s nextPutAll: 'v := ']].
		alignedPowerOf2 ifFalse:
			[s nextPut: $(].
		shift ~= 0 ifTrue:
			[s nextPut: $(].
		s nextPutAll: 'memory unsigned';
		   nextPutAll: (#('Byte' 'Short' 'Long' 'Long')
							at: endByte - startByte + 1
							ifAbsent: ['Long64']);
		  nextPutAll: 'At: address + '; print: startByte + 1.
		(self offsetForInstVar: getter) ifNotNil:
			[:offsetExpr| s nextPutAll: ' + '; nextPutAll: offsetExpr].
		shift ~= 0 ifTrue:
			[s nextPutAll: ') bitShift: -'; print: shift].
		alignedPowerOf2 ifFalse:
			[s nextPutAll: ') bitAnd: '; nextPutAll: ((1 << bitWidth) - 1) hex].
		typeOrNil ifNotNil:
			[s nextPutAll: ') ~= 0'.
			typeOrNil last = $* ifTrue:
				[s nextPutAll: ' ifTrue:';
					crtab: 2;
					nextPutAll: '[cogit cCoerceSimple: v to: ';
					store: typeOrNil;
					nextPut: $]]]]