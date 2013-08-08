tests
testNfib16
	"self new testNfib16"
	self should: [self runNFib: 16 disassemble: false printRegisters: false]
		raise: Error.
	self deny: (self processor pc between: 0 and: self nfib size).
	self assert: self processor r0 = 16 benchFib