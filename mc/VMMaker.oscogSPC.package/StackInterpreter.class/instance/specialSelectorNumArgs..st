message sending
specialSelectorNumArgs: index
	^objectMemory integerValueOf: (objectMemory fetchPointer: (index * 2) + 1 ofObject: (objectMemory splObj: SpecialSelectors))