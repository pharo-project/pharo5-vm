coercing
ccgLoad: aBlock expr: aString asOopPtrFrom: anInteger andThen: valBlock
	"Answer codestring for integer pointer to first indexable field of object (without validating side-effect unless specified in valBlock), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^(valBlock value: anInteger), '.',
	 (aBlock value: (String streamContents:
		[:aStream |
		aStream
			nextPutAll: 'self cCoerce: (interpreterProxy firstIndexableField:';
			crtab: 4;
			nextPutAll: '(interpreterProxy stackValue:';
			print: anInteger;
			nextPutAll:	'))';
			crtab: 3;
			nextPutAll: 'to: ''sqInt *''']))