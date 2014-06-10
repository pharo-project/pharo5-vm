initialization
generateEnilopmarts
	"Enilopmarts transfer control from C into machine code (backwards trampolines).
	 Override to add version for generic and PIC-specific entry with reg args."
	super generateEnilopmarts.

	self cppIf: Debug
		ifTrue:
			[realCEEnterCogCodePopReceiverArg0Regs :=
				self genEnilopmartFor: ReceiverResultReg
					and: Arg0Reg
					called: 'realCEEnterCogCodePopReceiverArg0Regs'.
			 ceEnterCogCodePopReceiverArg0Regs := #enterCogCodePopReceiverArg0Regs.
			 realCEEnterCogCodePopReceiverArg1Arg0Regs :=
				self genEnilopmartFor: ReceiverResultReg
					and: Arg0Reg							
					and: Arg1Reg
					called: 'realCEEnterCogCodePopReceiverArg1Arg0Regs'.
			 ceEnterCogCodePopReceiverArg1Arg0Regs := #enterCogCodePopReceiverArg1Arg0Regs]
		ifFalse:
			[ceEnterCogCodePopReceiverArg0Regs :=
				self genEnilopmartFor: ReceiverResultReg
					and: Arg0Reg
					called: 'ceEnterCogCodePopReceiverArg0Regs'.
			 ceEnterCogCodePopReceiverArg1Arg0Regs :=
				self genEnilopmartFor: ReceiverResultReg
					and: Arg0Reg							
					and: Arg1Reg
					called: 'ceEnterCogCodePopReceiverArg1Arg0Regs'].

	"These are special versions of the ceEnterCogCodePopReceiverAndClassRegs enilopmart that also
	 pop register argsfrom the stack to undo the pushing of register args in the abort/miss trampolines."
	ceEnter0ArgsPIC := self genEnterPICEnilopmartNumArgs: 0.
	self numRegArgs >= 1 ifTrue:
		[ceEnter1ArgsPIC := self genEnterPICEnilopmartNumArgs: 1.
		 self numRegArgs >= 2 ifTrue:
			[ceEnter2ArgsPIC := self genEnterPICEnilopmartNumArgs: 2.
			 self assert: self numRegArgs = 2]]