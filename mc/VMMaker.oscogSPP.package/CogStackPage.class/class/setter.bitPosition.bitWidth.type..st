code generation
setter: getter bitPosition: bitPosition bitWidth: bitWidth type: typeOrNil
	^String streamContents:
		[:s| | startByte endByte accessor |
		startByte := bitPosition // 8.
		endByte := bitPosition + bitWidth - 1 // 8.
		self assert: bitPosition \\ 8 = 0.
		self assert: startByte \\ (bitWidth // 8) = 0.
		accessor := #('byte' 'short' 'long' 'long')
							at: endByte - startByte + 1
							ifAbsent: ['long64'].
		s	nextPutAll: getter; nextPutAll: ': aValue'; crtab: 1;
			nextPutAll: 'self assert: (address + '; print: startByte;
			nextPutAll: ' >= zoneBase and: [address + '; print: endByte;
			nextPutAll: ' < zoneLimit]).'; crtab: 1.
		(typeOrNil notNil and: [typeOrNil last = $*]) ifTrue:
			[accessor := 'unsigned', (accessor copy
										at: 1 put: accessor first asUppercase;
										yourself)].
		(typeOrNil notNil and: ['*StackPage*' match: typeOrNil]) ifFalse:
			[s nextPut: $^].
		s nextPutAll: 'memory ';
		   nextPutAll: accessor; nextPutAll: 'At: address + '; print: startByte + 1;
		   nextPutAll: ' put: aValue'.
		(typeOrNil notNil and: ['*StackPage*' match: typeOrNil]) ifTrue:
			[s nextPutAll: ' asInteger.'; crtab: 1; nextPutAll: '^aValue']]

	"| bitPosition |
	bitPosition := 0.
	(self fieldAccessorsForBytesPerWord: 4) collect:
		[:spec|
		bitPosition := bitPosition + spec second.
		self setter: spec first
			 bitPosition: bitPosition - spec second
			 bitWidth: spec second
			 type: (spec at: 3 ifAbsent: [])]"