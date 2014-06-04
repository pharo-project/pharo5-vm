tests
testArcTan2
	| hash |
	hash := self runTest:[:f| self arcTan2: f with: f].
	self assert: hash = 287068347279655848752274030373495709564