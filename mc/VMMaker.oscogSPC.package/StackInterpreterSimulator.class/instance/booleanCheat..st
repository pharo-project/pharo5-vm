utilities
booleanCheat: cond
	disableBooleanCheat
		ifTrue: [self internalPop: 2
					thenPush: (cond
								ifTrue: [objectMemory trueObject]
								ifFalse: [objectMemory falseObject]).
				self fetchNextBytecode]
		ifFalse: [super booleanCheat: cond]