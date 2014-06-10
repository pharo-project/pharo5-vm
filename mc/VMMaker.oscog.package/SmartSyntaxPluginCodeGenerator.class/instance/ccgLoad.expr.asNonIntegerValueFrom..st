coercing
ccgLoad: aBlock expr: aString asNonIntegerValueFrom: anInteger
	"Answer codestring for oop (with validating side effect), as described in comment to ccgLoad:expr:asRawOopFrom:"

	^aBlock value: (String streamContents: [:aStream | aStream
		nextPutAll: 'interpreterProxy stackObjectValue: ';
		nextPutAll: anInteger asString])