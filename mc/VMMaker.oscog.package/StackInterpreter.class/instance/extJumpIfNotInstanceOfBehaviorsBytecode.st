sista bytecodes
extJumpIfNotInstanceOfBehaviorsBytecode
	"254		11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0)"
	| tosClassTag literal distance |
	SistaVM ifFalse: [^self respondToUnknownBytecode].
	tosClassTag := objectMemory fetchClassTagOf: self internalPopStack.
	literal := self literal: extA << 8 + self fetchByte.
	distance := extB << 8 + self fetchByte.
	extA := 0.
	extB := 0.
	(objectMemory isArrayNonImm: literal)
		ifTrue:
			[0 to: (objectMemory numSlotsOf: literal) asInteger - 1 do: [:i |
				tosClassTag = (objectMemory rawClassTagForClass: (objectMemory fetchPointer: i ofObject: literal))
					ifTrue: [ ^ self fetchNextBytecode ] ].
			 localIP := localIP + distance.
			 ^ self fetchNextBytecode]
		ifFalse:
			[tosClassTag ~= (objectMemory rawClassTagForClass: literal) ifTrue:
				[localIP := localIP + distance.
				^ self fetchNextBytecode]].
	self fetchNextBytecode