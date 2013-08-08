tests
testNfib16
	"self new testNfib16"
	self should: [self runNFib: 16 disassemble: false printRegisters: false]
		raise: Error.
	self deny: (self processor eip between: 1 and: self nfib size).
	self assert: self processor eax = 16 benchFib