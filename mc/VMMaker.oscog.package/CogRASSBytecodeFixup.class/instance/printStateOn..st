debug printing
printStateOn: aStream
	<doNotGenerate>
	(targetInstruction isNil and: [simStackPtr isNil]) ifTrue:
		[^self].
	super printStateOn: aStream.
	mergeSimStack ifNotNil:
		[aStream skip: -1; space; nextPut: $(.
		 cogit printSimStack: mergeSimStack toDepth: simStackPtr spillBase: -1 on: aStream.
		 aStream nextPut: $); nextPut: $)]