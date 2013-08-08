tests
testStepNfib1
	"self new testStepNfib1"
	self singleStepNFib: 1 disassemble: false printRegisters: false.
	self assert: self processor pc = (self nfib asWordArray size * 4).
	self assert: self processor r0 = 1 benchFib