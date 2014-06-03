tests
testArcTan
	| hash |
	hash := self runTest:[:f| self arcTan: f].
	self assert: hash = 17311773710959114634056077345168823659