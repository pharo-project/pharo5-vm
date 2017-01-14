tests
testArcCosH
	| hash |
	hash := self runTest:[:f| self arcCosH: f].
	self assert: hash = 6724426144112251941037505276242428134