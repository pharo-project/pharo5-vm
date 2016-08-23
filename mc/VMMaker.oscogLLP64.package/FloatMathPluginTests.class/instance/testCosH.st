tests
testCosH
	| hash |
	hash := self runTest:[:f| self cosH: f].
	self assert: hash = 139309299067563830037108641802292492276