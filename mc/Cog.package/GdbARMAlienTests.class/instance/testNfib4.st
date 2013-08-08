tests
testNfib4
	"self new testNfib4"
	self should: [self runNFib: 4 disassemble: false printRegisters: false]
		raise: Error.
	self deny: (self processor pc between: 0 and: self nfib size).
	self assert: self processor r0 = 4 benchFib