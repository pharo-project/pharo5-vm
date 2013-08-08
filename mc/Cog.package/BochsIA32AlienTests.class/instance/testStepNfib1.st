tests
testStepNfib1
	"self new testNfib1"
	self singleStepNFib: 1 disassemble: false printRegisters: false.
	self assert: self processor eip = self nfib size.
	self assert: self processor eax = 1 benchFib