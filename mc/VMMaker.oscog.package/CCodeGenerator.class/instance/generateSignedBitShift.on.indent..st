C translation
generateSignedBitShift: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| arg |
	(arg := msgNode args first) isConstant
		ifTrue: "bit shift amount is a constant"
			[aStream nextPut: $(; nextPutAll: '(signed)'.
			self emitCExpression: msgNode receiver on: aStream.
			arg value < 0
				ifTrue: [aStream nextPutAll: ' >> ', arg value negated printString]
				ifFalse: [aStream nextPutAll: ' << ', arg value printString].
			aStream nextPut: $)]
		ifFalse: "bit shift amount is an expression"
			[aStream nextPutAll: '(('.
			self emitCExpression: arg on: aStream.
			aStream nextPutAll: ' < 0) ? ('; nextPutAll: '(signed)'.
			self emitCExpression: msgNode receiver on: aStream.
			aStream nextPutAll: ' >> -'.
			self emitCExpression: arg on: aStream.
			aStream nextPutAll: ') : ('; nextPutAll: '(signed)'.
			self emitCExpression: msgNode receiver on: aStream.
			aStream nextPutAll: ' << '.
			self emitCExpression: arg on: aStream.
			aStream nextPutAll: '))']