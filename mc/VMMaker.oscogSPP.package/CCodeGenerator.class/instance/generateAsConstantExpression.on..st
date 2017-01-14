C translation support
generateAsConstantExpression: msgNode on: aStream
	"Attempt to generate the C code for this message onto the given stream.
	 Answer if the attempt succeeded.  This handles integer overflow of int
	 expressions in a 64-bit compiler."

	msgNode constantNumbericValueOrNil ifNotNil:
		[:value|
		 (value between: -1 << 31 and: 1 << 31 - 1) ifFalse:
			[aStream nextPutAll: (self cLiteralFor: value).
			 ^true]].
	^false