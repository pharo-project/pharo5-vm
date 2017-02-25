C translation
generateInlineCCodeAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream.
	 There are two forms, self cCode: aString ... and self cCode: aBlock."

	(msgNode args first isConstant
	 and: [msgNode args first value isString])
		ifTrue:
			[(msgNode args first value at: 1 ifAbsent: nil) = $# ifTrue:
				[aStream cr].
			aStream nextPutAll: msgNode args first value]
		ifFalse: [msgNode args first
					emitCCodeAsArgumentOn: aStream
					level: level
					generator: self]