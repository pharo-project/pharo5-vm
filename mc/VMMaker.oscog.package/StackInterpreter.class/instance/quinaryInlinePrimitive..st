miscellaneous bytecodes
quinaryInlinePrimitive: primIndex
	"SistaV1:	248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution."
	| src srcIndex dest destIndex destLimit oop |
	<option: #SistaVM>
	primIndex = 0 ifFalse: [self respondToUnknownBytecode].
	dest := self internalStackValue: 4.
	destIndex := (objectMemory integerValueOf: (self internalStackValue: 3)) - 1.
	destLimit := (objectMemory integerValueOf: (self internalStackValue: 2)) - 1.
	src := self internalStackValue: 1.
	srcIndex := (objectMemory integerValueOf: (self internalStackValue: 0)) - 1.
	self internalPop: 4.
	destLimit < destIndex ifTrue: [^self].
	(objectMemory isYoung: dest) ifFalse: [objectMemory possibleRootStoreInto: dest].
	0 to: destLimit - destIndex do: [:i |
		oop := objectMemory fetchPointer: srcIndex + i ofObject: src.
		objectMemory storePointerUnchecked: destIndex + i ofObject: dest withValue: oop ].
	