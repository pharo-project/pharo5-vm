stack bytecodes
pushNewArrayBytecode
	| size popValues array |
	size := self fetchByte.
	popValues := size > 127.
	size := size bitAnd: 127.
	self fetchNextBytecode.
	self externalizeIPandSP.
	array := self instantiateClass: (self splObj: ClassArray) indexableSize: size.
	self internalizeIPandSP.
	popValues ifTrue:
		[0 to: size - 1 do:
			[:i|
			"Assume: have just allocated a new Array; it must be young. Thus, can use unchecked stores."
			self storePointerUnchecked: i ofObject: array withValue: (self internalStackValue: size - i - 1)].
		 self internalPop: size].
	self internalPush: array