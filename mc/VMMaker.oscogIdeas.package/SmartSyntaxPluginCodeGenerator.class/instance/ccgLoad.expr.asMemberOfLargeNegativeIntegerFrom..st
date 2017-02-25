coercing
ccgLoad: aBlock expr: aString asMemberOfLargeNegativeIntegerFrom: anInteger 

	^String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy success: (interpreterProxy isLargeNegativeIntegerObject: (interpreterProxy stackValue: ';
		nextPutAll: anInteger asString;
		nextPutAll: ')).';
		crtab;
		nextPutAll: (self 
						ccgLoad: aBlock 
						expr: aString 
						asRawOopFrom: anInteger)]