printing
printStateOn: aStream
	<doNotGenerate>
	annotation ifNotNil:
		[aStream
			space; nextPut: $(;
			nextPutAll: (Cogit annotationConstantNames at: annotation + 1);
			space; print: instruction; nextPut: $)]