bytecode generator support
genSendDynamicSuper: selectorIndex numArgs: numArgs
	self marshallSendArguments: numArgs.
	^self genMarshalledSend: selectorIndex numArgs: numArgs sendTable: dynamicSuperSendTrampolines