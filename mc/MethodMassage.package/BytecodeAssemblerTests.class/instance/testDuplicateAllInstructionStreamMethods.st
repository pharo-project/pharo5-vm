tests
testDuplicateAllInstructionStreamMethods
	InstructionStream withAllSuperclasses, InstructionStream allSubclasses do:
		[:isc|
		self testDuplicateMethodsFor: isc
			if: [:method| true]]