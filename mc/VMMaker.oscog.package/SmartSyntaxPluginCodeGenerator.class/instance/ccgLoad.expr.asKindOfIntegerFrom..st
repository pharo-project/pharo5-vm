coercing
ccgLoad: aBlock expr: aString asKindOfIntegerFrom: anInteger 

	^String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy success: (interpreterProxy isKindOfInteger: (interpreterProxy stackValue: ';
		nextPutAll: anInteger asString;
		nextPutAll: ')).';
		crtab;
		nextPutAll: (self 
						ccgLoad: aBlock 
						expr: aString 
						asRawOopFrom: anInteger)]