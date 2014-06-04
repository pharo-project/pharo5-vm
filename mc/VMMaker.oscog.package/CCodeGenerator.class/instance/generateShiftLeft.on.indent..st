C translation
generateShiftLeft: msgNode on: aStream indent: level
	"Generate a C bitShift.  If we can determine the result
	 would overflow the word size, cast to a long integer."
	| rcvr arg |
	rcvr := msgNode receiver.
	arg := msgNode args first.
	self emitCExpression: rcvr on: aStream.
	(rcvr isConstant and: [arg isConstant
	 and: [rcvr value isInteger and: [arg value isInteger
	 and: [rcvr value < (1 bitShift: BytesPerWord * 8)
	 and: [(rcvr value bitShift: arg value) >= (1 bitShift: BytesPerWord * 8)]]]]]) ifTrue:
		[aStream nextPutAll: 'LL'].
	aStream nextPutAll: ' << '.
	self emitCExpression: arg on: aStream