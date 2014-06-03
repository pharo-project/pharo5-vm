debug printing
printCurrentBytecodeOn: aStream
	| code |
	code := currentBytecode radix: 16.
	aStream print: localIP - method - 3;
		tab;
		nextPut: (code size < 2
					ifTrue: [$0]
					ifFalse: [code at: 1]);
		nextPut: code last; space;
		nextPutAll: (BytecodeTable at: currentBytecode + 1);
		space;
		nextPut: $(; print: byteCount; nextPut: $)