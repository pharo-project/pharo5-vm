debug printing
printStateOn: aStream
	<doNotGenerate>
	targetInstruction ifNotNil:
		[aStream space; nextPut: $(; print: targetInstruction; nextPutAll: ' bc '; print: bcpc; nextPut: $)]