C translation
generateBitShift: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| arg rcvr |
	arg := msgNode args first.
	rcvr := msgNode receiver.
	arg isConstant
		ifTrue: "bit shift amount is a constant"
			[aStream nextPutAll: '((usqInt) '.
			self emitCExpression: rcvr on: aStream.
			arg value < 0
				ifTrue: [aStream nextPutAll: ' >> ', arg value negated printString]
				ifFalse: [aStream nextPutAll: ' << ', arg value printString].
			aStream nextPutAll: ')']
		ifFalse: "bit shift amount is an expression"
			[aStream nextPutAll: '(('.
			self emitCExpression: arg on: aStream indent: level.
			aStream nextPutAll: ' < 0) ? ((usqInt) '.
			self emitCExpression: rcvr on: aStream indent: level.
			aStream nextPutAll: ' >> -'.
			self emitCExpression: arg on: aStream indent: level.
			aStream nextPutAll: ') : ((usqInt) '.
			self emitCExpression: rcvr on: aStream indent: level.
			aStream nextPutAll: ' << '.
			self emitCExpression: arg on: aStream indent: level.
			aStream nextPutAll: '))']