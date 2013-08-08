message sending
specialSelector: index

	^ objectMemory fetchPointer: (index * 2) ofObject: (objectMemory splObj: SpecialSelectors)