bytecode generators
genSendSuper: selector numArgs: numArgs
	self marshallSendArguments: numArgs.
	^self genMarshalledSend: selector numArgs: numArgs sendTable: superSendTrampolines