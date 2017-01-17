tests-method map
testPCMappingForCompiledMethod: aCompiledMethod cogMethod: cm
	<doNotGenerate>
	methodObj := methodHeader := nil.
	self
		testMcToBcPcMappingForCompiledMethod: aCompiledMethod cogMethod: cm;
		testBcToMcPcMappingForCogMethod: cm