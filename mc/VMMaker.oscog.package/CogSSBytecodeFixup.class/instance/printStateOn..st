debug printing
printStateOn: aStream
	<doNotGenerate>
	(targetInstruction isNil and: [simStackPtr isNil]) ifTrue:
		[^self].
	aStream space; nextPut: $(.
	targetInstruction ifNotNil:
		[aStream space; print: targetInstruction].
	simStackPtr ifNotNil:
		[aStream nextPutAll: ' sp '; print: simStackPtr].
	bcpc ifNotNil:
		[aStream nextPutAll: ' bc '; print: bcpc].
	aStream nextPut: $)