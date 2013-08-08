debug printing
printStateOn: aStream
	<doNotGenerate> "Smalltalk-side only"
	generator ifNil:
		[^self].
	aStream space; nextPut: $(; nextPutAll: generator; space; print: numBytes.
	needsFrameFunction ifNotNil: [aStream space; nextPutAll: needsFrameFunction].
	spanFunction ifNotNil: [:func| aStream space; nextPutAll: func].
	isReturn ifTrue: [aStream nextPutAll: ' isReturn'].
	opcode ifNotNil: [aStream space; nextPutAll: (CogRTLOpcodes nameForOpcode: opcode)].
	aStream nextPut: $)