as yet unclassified
assertCheckQuickArithOpCodeSize: bytes
	self flag: #todo. "We always generate the full 3 instructions for now."
	self assert: bytes = 12