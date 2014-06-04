printing
nameForRegister: reg "<Integer>"
	
	<doNotGenerate>
	^#(LR SP PC CArg0Reg CArg0Reg CArg1Reg CArg2Reg CArg3Reg) detect: [:sym| (self class classPool at: sym) = reg] 
		ifNone: [super nameForRegister: reg]