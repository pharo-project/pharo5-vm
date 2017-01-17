code generation
getter: getter bitPosition: bitPosition bitWidth: bitWidth type: typeOrNil
	^String streamContents:
		[:s| | startByte endByte accessor |
		startByte := bitPosition // 8.
		endByte := bitPosition + bitWidth - 1 // 8.
		self assert: bitPosition \\ 8 = 0.
		self assert: startByte \\ (bitWidth // 8) = 0.
		accessor := #('byte' 'short' 'long' 'long')
							at: endByte - startByte + 1
							ifAbsent: ['long64'].
		s	nextPutAll: getter; crtab: 1; nextPut: $^.
		(typeOrNil notNil and: [typeOrNil last = $*]) ifTrue:
			[accessor := 'unsigned', (accessor copy
										at: 1 put: accessor first asUppercase;
										yourself)].
		(typeOrNil notNil and: ['*StackPage*' match: typeOrNil]) ifTrue:
			[s nextPutAll: 'stackPages surrogateAtAddress: ('].
		s nextPutAll: 'memory ';
		   nextPutAll: accessor;
		   nextPutAll: 'At: address + '; print: startByte + 1.
		(typeOrNil notNil and: ['*StackPage*' match: typeOrNil]) ifTrue:
			[s nextPut: $)]]

	"| bitPosition |
	bitPosition := 0.
	(self fieldAccessorsForBytesPerWord: 4) collect:
		[:spec|
		bitPosition := bitPosition + spec second.
		self getter: spec first
			 bitPosition: bitPosition - spec second
			 bitWidth: spec second
			 type: (spec at: 3 ifAbsent: [])]"