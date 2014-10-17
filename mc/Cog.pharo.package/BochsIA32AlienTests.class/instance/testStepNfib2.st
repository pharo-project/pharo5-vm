tests
testStepNfib2
	"self new testNfib2"
	self singleStepNFib: 2 disassemble: false printRegisters: false.
	self assert: self processor eip = self nfib size.
	self assert: self processor eax = 2 benchFib