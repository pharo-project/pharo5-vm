compiled methods
isNullExternalPrimitiveCall: aMethodObj
	"Answer if the method is an external primtiive call (prim 117) with a null external primtiive.
	 This is just for an assert in the CoInterpreter."
	| lit |
	((self isExternalPrimitiveCall: aMethodObj)
	and: [(objectMemory literalCountOf: aMethodObj) > 0]) ifFalse:
		[^false].

	lit := self literal: 0 ofMethod: aMethodObj.
	^(objectMemory isArray: lit)
	  and: [(objectMemory numSlotsOf: lit) = 4
	  and: [(objectMemory fetchPointer: 3 ofObject: lit) = ConstZero
			or: [(objectMemory fetchPointer: 3 ofObject: lit) = ConstMinusOne]]]