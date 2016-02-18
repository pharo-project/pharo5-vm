C translation
generateSequentialAnd: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode receiver)
		ifNil:
			[self emitCExpression: msgNode receiver on: aStream indent: level.
			 "Don't eliminate the first expression if the second one is false, because of potential side-effects;
			  leave that to the C compiler. But /do/ eliminate the second expression if it is vaccuously true."
			 (self nilOrBooleanConstantReceiverOf: msgNode args first) ifNotNil:
				[:const| const == true ifTrue: [^self]].
			 aStream crtab: level; nextPutAll: ' && ('.
			 self emitCTestBlock: msgNode args first on: aStream indent: level.
			 aStream nextPut: $)]
		ifNotNil:
			[:const |
			const
				ifTrue: [self emitCTestBlock: msgNode args first on: aStream indent: level]
				ifFalse: [aStream nextPut: $0]]