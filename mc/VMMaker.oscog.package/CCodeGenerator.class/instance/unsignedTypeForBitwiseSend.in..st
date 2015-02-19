type inference
unsignedTypeForBitwiseSend: aTSendNode in: aTMethod
	"The result of the bitwise operators in C is unsigned.
	 We make an exception for currentBytecode bitAnd: N to allow better inlining in cases."
	| t1 t2 type |
	(aTSendNode receiver isVariable
	and: [aTSendNode receiver name = 'currentBytecode'
	and: [aTSendNode selector == #bitAnd:]]) ifTrue:
		[^#sqInt].
	t1 := (self typeFor: aTSendNode receiver in: aTMethod) ifNil: [^nil].
	t2 := (self typeFor: aTSendNode args first in: aTMethod) ifNil: [^nil].
	type := (self sizeOfIntegralCType: t1) >= (self sizeOfIntegralCType: t1)
				ifTrue: [t1]
				ifFalse: [t2].
	^type first = $u
		ifTrue: [type]
		ifFalse:
			[(type beginsWith: 'sq')
				ifTrue: ['u', type]
				ifFalse: ['unsigned ', type]]