C translation
generateSignedShiftRight: msgNode on: aStream indent: level
	"Generate the C code for >>> onto the given stream."

	(self is64BitIntegralVariable: msgNode receiver typeInto: [:t|])
		ifTrue:
			[aStream nextPutAll: '((sqLong) ']
		ifFalse:
			[aStream nextPutAll: '((sqInt) '].
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ') >> '.
	self emitCExpression: msgNode args first on: aStream