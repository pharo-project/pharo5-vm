tests
testCos
	| hash |
	hash := self runTest:[:f| self cos: f].
	self assert: hash = 110207739557966732640546618158077332978