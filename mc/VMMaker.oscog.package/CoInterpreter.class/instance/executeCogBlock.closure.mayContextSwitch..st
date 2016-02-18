enilopmarts
executeCogBlock: cogMethod closure: closure mayContextSwitch: mayContextSwitch
	"Execute a block within a CogMethod.  The caller has already pushed the block and
	 any arguments and the return pc.  First push the return-to-interpreter trampoline,
	 then the entry-point and finally the receiver.  We /do not/ push any register
	 argument(s) to reduce complications in block dispatch; effectively there are no
	 register arguments to blocks. Instead, the machine code block value primitives
	 push the reg args if necessary before dispatching to the block.  Hence here, only
	 the receiver gets pushed. See genPrimitiveClosureValue"
	<var: #cogMethod type: #'CogMethod *'>
	cogit assertCStackWellAligned.
	self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer.
	self ensurePushedInstructionPointer.
	self push: cogMethod asInteger
			+ (mayContextSwitch
				ifTrue: [cogMethod blockEntryOffset]
				ifFalse: [cogMethod blockEntryOffset - cogit noContextSwitchBlockEntryOffset]).
	self push: closure.
	cogit ceCallCogCodePopReceiverReg
	"NOTREACHED"