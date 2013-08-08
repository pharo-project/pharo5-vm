tests-method map
testPCMappingForMethod: cm
	<doNotGenerate>
	methodObj := nil.
	self
		testMcToBcPcMappingForMethod: cm;
		testBcToMcPcMappingForMethod: cm