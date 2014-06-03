tests
testArcTanH
	| hash |
	hash := self runTest:[:f| self arcTanH: f].
	self assert: hash = 295711907369004359459882231908879164929