tests
testStepNfib4
	"self new testNfib4"
	self singleStepNFib: 4 disassemble: false printRegisters: false.
	self assert: self processor eip = self nfib size.
	self assert: self processor eax = 4 benchFib