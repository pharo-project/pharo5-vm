tests
testLog10
	| hash |
	hash := self runTest:[:f| self log10: f abs].
	self assert: hash = 135564553959509933253581837789050718785