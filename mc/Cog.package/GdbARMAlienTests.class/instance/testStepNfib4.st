tests
testStepNfib4
	"self new testStepNfib4"
	self singleStepNFib: 4 disassemble: false printRegisters: false.
	self assert: self processor pc = (self nfib size * 4).
	self assert: self processor r0 = 4 benchFib