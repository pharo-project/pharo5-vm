sista bytecodes
extJumpIfNotInstanceOfBehaviorsOrPopBytecode
	"254		11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0)"
	| tosClassTag literal distance |
	tosClassTag := objectMemory fetchClassTagOf: self internalStackTop.
	literal := self literal: extA << 8 + self fetchByte.
	distance := extB << 8 + self fetchByte.
	extA := 0.
	extB := 0.
	(objectMemory isArrayNonImm: literal)
		ifTrue:
			[| i |
			 i := (objectMemory numSlotsOf: literal) asInteger.
			 [(i := i -1) < 0
			  or: [tosClassTag = (objectMemory rawClassTagForClass: (objectMemory fetchPointer: i ofObject: literal))]] whileTrue.
			 i < 0 ifTrue:
				[localIP := localIP + distance.
				^ self fetchNextBytecode]]
		ifFalse:
			[tosClassTag ~= (objectMemory rawClassTagForClass: literal) ifTrue:
				[localIP := localIP + distance.
				^ self fetchNextBytecode]].
	self internalPopStack.
	self fetchNextBytecode