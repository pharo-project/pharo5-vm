tests
testNfib2
	"self new testNfib2"
	self should: [self runNFib: 2 disassemble: false printRegisters: false]
		raise: Error.
	self deny: (self processor eip between: 1 and: self nfib size).
	self assert: self processor eax = 2 benchFib