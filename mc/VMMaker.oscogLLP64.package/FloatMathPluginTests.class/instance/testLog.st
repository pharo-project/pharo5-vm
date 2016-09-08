tests
testLog
	| hash |
	hash := self runTest:[:f| self ln: f abs].
	self assert: hash = 24389651894375564945708989023746058645