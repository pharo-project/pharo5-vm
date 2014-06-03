tests
testSinH
	| hash |
	hash := self runTest:[:f| self sinH: f].
	self assert: hash = 146029709156303766079448006055284064911