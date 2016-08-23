coercing
ccgLoad: aBlock expr: aString asUnsignedValueFrom: anInteger
	"Answer a codestring for positive integer coercion (with validating side-effect) of oop, as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream |
		aStream
			nextPutAll: '(interpreterProxy bytesPerOop = 4';
			crtab: 2;
			nextPutAll: 'ifTrue: [interpreterProxy positive32BitValueOf:';
			crtab: 4;
			nextPutAll: '(interpreterProxy stackValue:';
			print: anInteger;
			nextPutAll: ')]';
			crtab: 2;
			nextPutAll: 'ifFalse: [interpreterProxy positive64BitValueOf:';
			crtab: 4;
			nextPutAll: '(interpreterProxy stackValue:';
			print: anInteger;
			nextPutAll: ')])'])