tests
testStepNfib2
	"self new testStepNfib2"
	self singleStepNFib: 2 disassemble: false printRegisters: false.
	self assert: self processor pc = (self nfib size * 4).
	self assert: self processor r0 = 2 benchFib