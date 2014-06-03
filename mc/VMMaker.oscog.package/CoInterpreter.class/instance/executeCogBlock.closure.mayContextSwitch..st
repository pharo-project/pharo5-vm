enilopmarts
executeCogBlock: cogMethod closure: closure mayContextSwitch: mayContextSwitch
	"Execute a block within a CogMethod.  The caller has already pushed
	 the block and any arguments and the return pc.  First push the
	 return-to-interpreter trampoline, then the entry-point and finally the
	 register argument(s).  Then jump to the block entry by executing a
	 return instruction.
	 In the simple jit only the receiver gets passed in registers, so only the
	 receiver gets pushed."
	<var: #cogMethod type: #'CogMethod *'>
	cogit assertCStackWellAligned.
	self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer.
	self ensurePushedInstructionPointer.
	self push: cogMethod asInteger
			+ (mayContextSwitch
				ifTrue: [cogMethod blockEntryOffset]
				ifFalse: [cogMethod blockEntryOffset - cogit noContextSwitchBlockEntryOffset]).
	self push: closure.
	cogit ceEnterCogCodePopReceiverReg
	"NOTREACHED"