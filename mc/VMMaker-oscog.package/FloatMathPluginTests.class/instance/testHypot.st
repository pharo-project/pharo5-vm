tests
testHypot
	| hash |
	hash := self runTest:[:f| self hypot: f with: f+1].
	self assert: hash = 217113721886532765853628735806816720346