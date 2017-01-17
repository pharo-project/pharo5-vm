tests
testArcCos
	| hash |
	hash := self runTest:[:f| self arcCos: f].
	self assert: hash = 320603091210691421897131240956682310429