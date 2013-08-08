tests
testNfib1
	"self new testNfib1"
	self should: [self runNFib: 1 disassemble: false printRegisters: false]
		raise: Error.
	self deny: (self processor eip between: 1 and: self nfib size).
	self assert: self processor eax = 1 benchFib