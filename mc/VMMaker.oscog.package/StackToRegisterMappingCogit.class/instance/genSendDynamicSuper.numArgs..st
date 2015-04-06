bytecode generator support
genSendDynamicSuper: selector numArgs: numArgs
	self marshallSendArguments: numArgs.
	^self genMarshalledSend: selector numArgs: numArgs sendTable: dynamicSuperSendTrampolines