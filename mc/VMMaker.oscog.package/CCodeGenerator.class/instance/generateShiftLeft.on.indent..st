C translation
generateShiftLeft: msgNode on: aStream indent: level
	"Generate a C bitShift.  If we can determine the result
	 would overflow the word size, cast to a long integer."
	| rcvr arg valueBeyondInt castToLong |
	rcvr := msgNode receiver.
	arg := msgNode args first.
	valueBeyondInt := 1 bitShift: 32. "The default type of const << N is int."
	castToLong := vmClass notNil and: [vmClass objectMemoryClass wordSize = 8].
	castToLong ifFalse:
		[rcvr constantNumbericValueOrNil ifNotNil:
			[:rcvrVal|
			 arg constantNumbericValueOrNil ifNotNil:
				[:argVal|
				 castToLong := rcvrVal < valueBeyondInt
								  and: [(rcvrVal bitShift: argVal) >= valueBeyondInt]]]].
	castToLong
		ifTrue:
			[(rcvr isConstant and: [rcvr name isEmpty])
				ifTrue:
					[self emitCExpression: rcvr on: aStream.
					 aStream nextPutAll: 'LL']
				ifFalse:
					[aStream nextPutAll: '((long)'.
					 self emitCExpression: rcvr on: aStream.
					 aStream nextPut: $)]]
		ifFalse:
			[self emitCExpression: rcvr on: aStream].
	aStream nextPutAll: ' << '.
	self emitCExpression: arg on: aStream