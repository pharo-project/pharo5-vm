tests
testNfib4
	"self new testNfib4"
	self should: [self runNFib: 4 disassemble: false printRegisters: false]
		raise: Error.
	self deny: (self processor eip between: 1 and: self nfib size).
	self assert: self processor eax = 4 benchFib