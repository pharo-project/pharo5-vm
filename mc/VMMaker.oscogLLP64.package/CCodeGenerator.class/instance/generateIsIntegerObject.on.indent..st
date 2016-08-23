C translation
generateIsIntegerObject: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	vmClass objectMemoryClass numSmallIntegerTagBits = 1
		ifTrue:
			[aStream nextPutAll: '('.
			 self emitCExpression: msgNode args first on: aStream.
			 aStream nextPutAll: ' & 1)']
		ifFalse:
			[aStream nextPutAll: '((('.
			 self emitCExpression: msgNode args first on: aStream.
			 aStream
				nextPutAll: ') & ';
				print: 1 << vmClass objectMemoryClass numSmallIntegerTagBits - 1;
				nextPutAll: ') == 1)']