tests
testNfib2
	"self new testNfib2"
	self should: [self runNFib: 2 disassemble: false printRegisters: false]
		raise: Error.
	self deny: (self processor pc between: 0 and: self nfib size).
	self assert: self processor r0 = 2 benchFib