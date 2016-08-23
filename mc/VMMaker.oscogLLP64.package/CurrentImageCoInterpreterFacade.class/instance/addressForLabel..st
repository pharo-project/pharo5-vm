labels
addressForLabel: l
	^variables at: l ifAbsentPut: [variables size * objectMemory wordSize + self variablesBase]