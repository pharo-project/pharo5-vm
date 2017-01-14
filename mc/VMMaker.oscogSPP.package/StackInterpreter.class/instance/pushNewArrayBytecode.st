stack bytecodes
pushNewArrayBytecode
	| size popValues array |
	size := self fetchByte.
	popValues := size > 127.
	size := size bitAnd: 127.
	self fetchNextBytecode.
	self externalizeIPandSP. "in case of abort"
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[array := objectMemory
						eeInstantiateSmallClassIndex: ClassArrayCompactIndex
						format: objectMemory arrayFormat
						numSlots: size]
		ifFalse:
			[array := objectMemory
						eeInstantiateClassIndex: ClassArrayCompactIndex
						format: objectMemory arrayFormat
						numSlots: size].
	popValues
		ifTrue:
			[0 to: size - 1 do:
				[:i|
				"Assume: have just allocated a new Array; it must be young. Thus, can use unchecked stores."
				objectMemory storePointerUnchecked: i ofObject: array withValue: (self internalStackValue: size - i - 1)].
			 self internalPop: size]
		ifFalse:
			[0 to: size - 1 do:
				[:i|
				objectMemory storePointerUnchecked: i ofObject: array withValue: objectMemory nilObject]].
	self internalPush: array