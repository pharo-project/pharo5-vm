initialization
genEnilopmartReturn: forCall
	"An enilopmart (the reverse of a trampoline) is a piece of code that makes
	 the system-call-like transition from the C runtime into generated machine
	 code.  At the point the enilopmart enters machine code via a return instruction,
	 any argument registers have been loaded with their values and the stack, if
	 for call, looks like
							ret pc
			stackPointer ->	target address

	 and if not for call, looks like
							whatever
			stackPointer ->	target address

	 If forCall and running on a CISC, ret pc must be left on the stack.  If forCall and
	 running on a RISC, ret pc must be popped into LinkReg.  In either case, target
	 address must be removed from the stack and jumped/returned to."

	backEnd hasLinkRegister
		ifTrue:
			[forCall
				ifTrue:
					[self PopR: RISCTempReg.
					 self PopR: LinkReg.
					 self JumpR: RISCTempReg]
				ifFalse:
					[backEnd hasPCRegister
						ifTrue: [self PopR: PCReg]
						ifFalse:
							[self PopR: RISCTempReg.
							 self JumpR: RISCTempReg]]]
		ifFalse:
			[self RetN: 0]