tests
testArcSinH
	| hash |
	hash := self runTest:[:f| self arcSinH: f].
	self assert: hash = 255911863578190171815115260235896145802