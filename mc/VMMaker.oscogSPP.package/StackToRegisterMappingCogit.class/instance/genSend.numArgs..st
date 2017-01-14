bytecode generator support
genSend: selectorIndex numArgs: numArgs
	self marshallSendArguments: numArgs.
	^self genMarshalledSend: selectorIndex numArgs: numArgs sendTable: ordinarySendTrampolines