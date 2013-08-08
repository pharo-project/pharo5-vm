bytecode generators
genSend: selector numArgs: numArgs
	self marshallSendArguments: numArgs.
	^self genMarshalledSend: selector numArgs: numArgs