in-image compilation
genAndDis: compiledBlock numCopied: numCopied options: optionsDictionaryOrArray
	| tuple |
	tuple := self cog: compiledBlock selectorOrNumCopied: numCopied options: optionsDictionaryOrArray.
	tuple second disassembleMethod: tuple last.
	^tuple