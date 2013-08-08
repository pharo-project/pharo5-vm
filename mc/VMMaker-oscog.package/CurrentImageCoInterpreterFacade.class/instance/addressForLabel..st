labels
addressForLabel: l
	^variables at: l ifAbsentPut: [variables size * 4 + 131072]