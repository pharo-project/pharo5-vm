tests
testTimesTwoPower
	| hash |
	hash := self runTest:[:f| self timesTwoPower: f with: (random nextInt: 200) - 100].
	self assert: hash = 278837335583284459890979576373223649870.