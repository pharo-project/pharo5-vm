tests
testArcSin
	| hash |
	hash := self runTest:[:f| self arcSin: f].
	self assert: hash = 27372132577303862731837100895783885417