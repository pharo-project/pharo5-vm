cog jit support
mapFunctionToAddress: aSymbolOrIndexOrBlock
	"Hackery to deal with the plugin primitive simulation hoops.
	 aSymbolOrIndex is either a Symbol (#primitiveExternalCall) or an
	 index above 1001 (an index + 1000 into the externalPrimitiveTable)."
	| sobui symbolOrBlock |
	aSymbolOrIndexOrBlock = 0 ifTrue: [^0].
	self assert: (aSymbolOrIndexOrBlock isSymbol
				or: [aSymbolOrIndexOrBlock isBlock
				or: [aSymbolOrIndexOrBlock isInteger
					and: [aSymbolOrIndexOrBlock between: 1001 and: 2000]]]).
	symbolOrBlock := aSymbolOrIndexOrBlock isInteger
						ifTrue: [(self pluginEntryFor: aSymbolOrIndexOrBlock) at: 3]
						ifFalse: [aSymbolOrIndexOrBlock].
	uniqueIndices ifNil:
		[uniqueIndices := Dictionary new.
		 uniqueIndex := 65535].
	sobui := uniqueIndices at: symbolOrBlock ifAbsentPut: [uniqueIndex := uniqueIndex + 1].
	^cogit
		mapPrimitive: symbolOrBlock
		withIndexToUniqueAddress: sobui