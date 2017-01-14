tests
testSin
	| hash |
	hash := self runTest:[:f| self sin: f].
	self assert: hash = 290162321010315440569513182938961037473