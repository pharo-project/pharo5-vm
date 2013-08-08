tests
testNfib1
	"self new testNfib1"
	self should: [self runNFib: 1 disassemble: false printRegisters: false]
		raise: Error
		withExceptionDo: 
			[:err| self assert: err messageText = 'Error 0: Illegal Instruction fetch address (0x1000).'].
	self deny: (self processor pc between: 0 and: self nfib size).
	self assert: self processor r0 = 1 benchFib