tests
testFloatAt
	| hash flt |
	flt := FloatArray new: 1.
	hash := self runTest:[:f| flt at: 1 put: f. flt at: 1].
	self assert: hash = 80498428122197125691266588764018905399