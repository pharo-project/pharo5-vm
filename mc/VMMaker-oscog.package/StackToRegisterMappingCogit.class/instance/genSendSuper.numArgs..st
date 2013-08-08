bytecode generators
genSendSuper: selector numArgs: numArgs
	self marshallSendArguments: numArgs.
	^self genMarshalledSendSuper: selector numArgs: numArgs