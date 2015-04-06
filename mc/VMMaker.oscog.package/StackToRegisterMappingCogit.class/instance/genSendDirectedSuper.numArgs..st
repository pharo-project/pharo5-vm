bytecode generator support
genSendDirectedSuper: selector numArgs: numArgs
	self halt: 'do all that good stuff moving the literal variable to an argument reg, etc...'.
	self marshallSendArguments: numArgs.
	^self genMarshalledSend: selector numArgs: numArgs sendTable: superSendTrampolines