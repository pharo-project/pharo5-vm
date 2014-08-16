sista bytecodes
extTrapIfNotInstanceOfBehaviorsBytecode
	"SistaV1: *	236	11101100	iiiiiiii	Trap If Not Instance Of Behavior/Array Of Behavior #iiiiiiii (+ Extend A * 256, where Extend A >= 0)"
	| tos tosClassTag literal |
	tos := self internalStackTop.
	tosClassTag := objectMemory fetchClassTagOf: tos.
	literal := self literal: extA << 8 + self fetchByte.
	extA := 0.
	(objectMemory isArrayNonImm: literal)
		ifTrue:
			[| i |
			 i := (objectMemory numSlotsOf: literal) asInteger.
			 [(i := i -1) < 0
			  or: [tosClassTag = (objectMemory rawClassTagForClass: (objectMemory fetchPointer: i ofObject: literal))]] whileTrue.
			 i < 0 ifTrue:
				[^self respondToClassTrap]]
		ifFalse:
			[tosClassTag ~= (objectMemory rawClassTagForClass: literal) ifTrue:
				[^self respondToClassTrap]].
	self internalPopStack.
	self fetchNextBytecode