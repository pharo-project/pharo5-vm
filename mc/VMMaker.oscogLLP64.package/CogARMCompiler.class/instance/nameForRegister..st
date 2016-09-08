printing
nameForRegister: reg "<Integer>"
	<doNotGenerate>
	| default |
	default := super nameForRegister: reg.
	^default last = $?
		ifTrue:
			[#(LR SP PC CArg0Reg CArg0Reg CArg1Reg CArg2Reg CArg3Reg)
				detect: [:sym| (thisContext method methodClass classPool at: sym) = reg] 
				ifNone: [default]]
		ifFalse:
			[default]