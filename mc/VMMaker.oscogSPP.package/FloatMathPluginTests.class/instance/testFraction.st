tests
testFraction
	| hash |
	hash := self runTest:[:f| self fractionPart: f].
	self assert: hash = 320444785026869345695277323179170692004