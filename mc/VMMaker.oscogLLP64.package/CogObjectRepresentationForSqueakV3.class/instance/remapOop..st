garbage collection
remapOop: oop
	^(objectMemory isIntegerObject: oop)
		ifTrue: [oop]
		ifFalse: [objectMemory remap: oop]