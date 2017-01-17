obj stacks
validObjStacks
	^(markStack = nilObj or: [self isValidObjStack: markStack])
	  and: [(weaklingStack = nilObj or: [self isValidObjStack: weaklingStack])
	  and: [mournQueue = nilObj or: [self isValidObjStack: mournQueue]]]