tests
testExp
	| hash |
	hash := self runTest:[:f| self exp: f].
	self assert: hash = 264681209343177480335132131244505189510