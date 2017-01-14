jump bytecodes
jumplfFalseBy: offset 
	| boolean |
	boolean := self internalStackTop.
	boolean = objectMemory falseObject
		ifTrue: [self jump: offset]
		ifFalse:
			[boolean = objectMemory trueObject ifFalse:
				[^self internalMustBeBoolean].
			self fetchNextBytecode].
	self internalPop: 1