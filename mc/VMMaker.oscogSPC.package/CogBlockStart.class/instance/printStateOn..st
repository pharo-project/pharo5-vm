printing
printStateOn: aStream
	<doNotGenerate> "Smalltalk-side only"
	aStream
		space; nextPut: $(;
		nextPutAll: 'numArgs: '; print: numArgs;
		nextPutAll: ' numCopied: '; print: numCopied;
		nextPutAll: ' numInitialNils: '; print: numInitialNils;
		nextPutAll: ' hasInstVarRef: '; print: hasInstVarRef;
		nextPutAll: ' startpc: '; print: startpc;
		nextPutAll: ' span: '; print: span;
		nextPut: $)