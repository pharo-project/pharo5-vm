cog jit support
specialSelectorNumArgs: index "<SmallInteger>"
	<api>
	^objectMemory integerValueOf: (objectMemory fetchPointer: (index * 2) + 1
							ofObject: (objectMemory splObj: SpecialSelectors))