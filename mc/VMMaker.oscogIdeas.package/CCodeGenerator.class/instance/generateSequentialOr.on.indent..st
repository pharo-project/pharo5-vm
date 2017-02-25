C translation
generateSequentialOr: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	"Note: PP 2.3 compiler produces two arguments for or:, presumably
	 to help with inlining later. Taking the last agument should do the correct
	 thing even if your compiler is different."

	(self nilOrBooleanConstantReceiverOf: msgNode receiver)
		ifNil:
			[self emitCExpression: msgNode receiver on: aStream indent: level.
			 "Don't eliminate the first expression if the second one is true, because of potential side-effects;
			  leave that to the C compiler. But /do/ eliminate the second expression if it is vaccuously false."
			 (self nilOrBooleanConstantReceiverOf: msgNode args last) ifNotNil:
				[:const| const == false ifTrue: [^self]].
			 aStream crtab: level; nextPutAll: ' || ('.
			 self emitCTestBlock: msgNode args last on: aStream indent: level.
			 aStream nextPut: $)]
		ifNotNil:
			[:const |
			const
				ifTrue: [aStream nextPut: $1]
				ifFalse: [self emitCTestBlock: msgNode args last on: aStream indent: level]]