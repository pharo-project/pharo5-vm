tests-method map
testPCMappingForCompiledMethod: aCompiledMethod cogMethod: cm
	<doNotGenerate>
	methodObj := nil.
	self
		testMcToBcPcMappingForCompiledMethod: aCompiledMethod cogMethod: cm;
		testBcToMcPcMappingForCompiledMethod: aCompiledMethod cogMethod: cm