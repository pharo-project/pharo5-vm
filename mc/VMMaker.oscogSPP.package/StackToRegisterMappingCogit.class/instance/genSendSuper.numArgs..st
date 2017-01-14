bytecode generator support
genSendSuper: selectorIndex numArgs: numArgs
	self marshallSendArguments: numArgs.
	^self genMarshalledSend: selectorIndex numArgs: numArgs sendTable: superSendTrampolines