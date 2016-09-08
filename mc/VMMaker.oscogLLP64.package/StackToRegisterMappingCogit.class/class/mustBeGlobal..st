translation
mustBeGlobal: var
	"Answer if a variable must be global and exported.  Used for inst vars that are accessed from VM support code."

	^(super mustBeGlobal: var)
	   or: [#('ceCallCogCodePopReceiverArg0Regs' 'ceCallCogCodePopReceiverArg1Arg0Regs'
			'realCECallCogCodePopReceiverArg0Regs' 'realCECallCogCodePopReceiverArg1Arg0Regs'
			'ceCall0ArgsPIC' 'ceCall1ArgsPIC' 'ceCall2ArgsPIC') includes: var]