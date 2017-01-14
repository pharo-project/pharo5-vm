sista bytecodes
extJumpIfNotInstanceOfBehaviorsBytecode
	"254		11111110	kkkkkkkk	jjjjjjjj		branch If Not Instance Of Behavior/Array Of Behavior kkkkkkkk (+ Extend A * 256, where Extend A >= 0) distance jjjjjjjj (+ Extend B * 256, where Extend B >= 0)"
	| tosClassTag literal distance inverse |
	SistaVM ifFalse: [^self respondToUnknownBytecode].
	extB < 0 
		ifTrue: [extB := extB + 128. inverse := true]
		ifFalse: [inverse := false].
	tosClassTag := objectMemory fetchClassTagOf: self internalPopStack.
	literal := self literal: extA << 8 + self fetchByte.
	distance := extB << 8 + self fetchByte.
	extA := 0.
	extB := 0.
	numExtB := 0.
	(objectMemory isArrayNonImm: literal)
		ifTrue:
			[0 to: (objectMemory numSlotsOf: literal) asInteger - 1 do: [:i |
				tosClassTag = (objectMemory rawClassTagForClass: (objectMemory fetchPointer: i ofObject: literal))
					ifTrue: [ 
						inverse ifTrue: [ localIP := localIP + distance ].
						^ self fetchNextBytecode ] ].
			 inverse ifFalse: [localIP := localIP + distance].
			 ^ self fetchNextBytecode]
		ifFalse:
			[tosClassTag ~= (objectMemory rawClassTagForClass: literal) ifTrue:
				[inverse ifFalse: [localIP := localIP + distance].
				^ self fetchNextBytecode]].
	inverse ifTrue: [localIP := localIP + distance].
	self fetchNextBytecode