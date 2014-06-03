translation
mustBeGlobal: var
	"Answer if a variable must be global and exported.  Used for inst vars that are accessed from VM support code."

	^(super mustBeGlobal: var)
	   or: [#('ceEnterCogCodePopReceiverArg0Regs' 'ceEnterCogCodePopReceiverArg1Arg0Regs'
			'realCEEnterCogCodePopReceiverArg0Regs' 'realCEEnterCogCodePopReceiverArg1Arg0Regs'
			'ceEnter0ArgsPIC' 'ceEnter1ArgsPIC' 'ceEnter2ArgsPIC') includes: var]