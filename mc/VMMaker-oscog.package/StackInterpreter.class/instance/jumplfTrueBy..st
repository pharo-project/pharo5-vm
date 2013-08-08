jump bytecodes
jumplfTrueBy: offset 
	| boolean |
	boolean := self internalStackTop.
	boolean = objectMemory trueObject
		ifTrue: [self jump: offset]
		ifFalse:
			[boolean = objectMemory falseObject ifFalse:
				[^self internalMustBeBoolean].
			self fetchNextBytecode].
	self internalPop: 1