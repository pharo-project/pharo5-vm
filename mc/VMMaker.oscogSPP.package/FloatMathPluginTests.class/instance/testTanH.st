tests
testTanH
	| hash |
	hash := self runTest:[:f| self tanH: f].
	self assert: hash = 15738508136206638425252880299326548123