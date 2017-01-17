tests
testTan
	| hash |
	hash := self runTest:[:f| self tan: f].
	self assert: hash = 207143885112027702205238433494882679660