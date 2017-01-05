C translation
generateShiftLeft: msgNode on: aStream indent: level
	"Generate a C bitShift.  If we can determine the result
	 would overflow the word size, cast to a long integer."
	| rcvr arg castToLong type mustCastBackToSign mustCastToUnsigned canSuffixTheConstant typeIsUnsigned |
	rcvr := msgNode receiver.
	arg := msgNode args first.
	castToLong := false.
	(rcvr constantNumbericValueIfAtAllPossibleOrNilIn: self) ifNotNil:
		[:rcvrVal |
		 (arg constantNumbericValueIfAtAllPossibleOrNilIn: self)
			ifNil: [castToLong := vmClass notNil and: [vmClass objectMemoryClass wordSize = 8]]
			ifNotNil:
				[:argVal |
				| valueBeyondInt |
				valueBeyondInt := 1 bitShift: 32. "The default type of const << N is int."
				castToLong := rcvrVal < valueBeyondInt
								  and: [(rcvrVal bitShift: argVal) >= valueBeyondInt]]].
	canSuffixTheConstant := rcvr isConstant and: [rcvr name isEmpty and: [rcvr value >= 0]].
	canSuffixTheConstant
		ifTrue:
			[aStream nextPutAll: (self cLiteralForUnsignedInteger: rcvr value longlong: castToLong).
			aStream nextPutAll: ' << '.
			self emitCExpression: arg on: aStream indent: level.
			^self].
	type := self typeFor: rcvr in: currentMethod.
	castToLong := castToLong and: [(self sizeOfIntegralCType: type) < (self sizeOfIntegralCType: #usqLong)].
	typeIsUnsigned := type first = $u.
	mustCastToUnsigned := typeIsUnsigned not
		or: [castToLong
		or: [(self sizeOfIntegralCType: type) < (self sizeOfIntegralCType: #usqInt)]].
	mustCastBackToSign := typeIsUnsigned not.
	mustCastBackToSign
		ifTrue:
			[| promotedType |
			promotedType := castToLong
				ifTrue: [#sqLong]
				ifFalse: [(self sizeOfIntegralCType: type) < (self sizeOfIntegralCType: #sqInt)
					ifTrue: [#sqInt]
					ifFalse: [type]].
			aStream nextPutAll: '(('; nextPutAll: promotedType; nextPut: $)].
	mustCastToUnsigned
		ifTrue:
			[| unsigned |
			unsigned := castToLong
				ifTrue: [#usqLong]
				ifFalse: [(self sizeOfIntegralCType: type) < (self sizeOfIntegralCType: #usqLong)
					ifTrue: [#usqInt]
					ifFalse: [self unsignedTypeForIntegralType: type]].
			aStream nextPutAll: '(('; nextPutAll: unsigned; nextPutAll: ')('].
	self emitCExpression: rcvr on: aStream indent: level.
	mustCastToUnsigned ifTrue: [aStream nextPut: $)].
		aStream nextPutAll: ' << '.
		self emitCExpression: arg on: aStream indent: level.
	mustCastToUnsigned ifTrue: [aStream nextPut: $)].
	mustCastBackToSign ifTrue: [aStream nextPut: $)].