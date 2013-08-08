tests
testSqrt
	| hash |
	hash := self runTest:[:f| self sqrt: f abs].
	self assert: hash = 112236588358122834093969606123302196127