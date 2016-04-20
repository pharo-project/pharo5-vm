coercing
ccgLoad: aBlock expr: aString asMemberOfLargePositiveIntegerFrom: anInteger 

	^String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy success: (interpreterProxy isLargePositiveIntegerObject: (interpreterProxy stackValue: ';
		nextPutAll: anInteger asString;
		nextPutAll: ')).';
		crtab;
		nextPutAll: (self 
						ccgLoad: aBlock 
						expr: aString 
						asRawOopFrom: anInteger)]