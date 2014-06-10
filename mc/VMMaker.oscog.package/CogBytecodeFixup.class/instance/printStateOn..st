debug printing
printStateOn: aStream
	<doNotGenerate>
	targetInstruction ifNotNil:
		[aStream space; nextPut: $(; print: targetInstruction; nextPut: $)]