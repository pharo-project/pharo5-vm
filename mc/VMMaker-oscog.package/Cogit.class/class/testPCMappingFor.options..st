tests
testPCMappingFor: aCompiledMethod options: optionsDictionaryOrArray
	| tuple |
	tuple := self cog: aCompiledMethod selector: aCompiledMethod selector options: optionsDictionaryOrArray.
	tuple second testPCMappingForMethod: tuple last