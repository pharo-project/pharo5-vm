tests
testPCMappingFor: aCompiledMethod options: optionsDictionaryOrArray
	| tuple |
	tuple := self cog: aCompiledMethod selectorOrNumCopied: aCompiledMethod selector options: optionsDictionaryOrArray.
	tuple second testPCMappingForCompiledMethod: aCompiledMethod cogMethod: tuple last