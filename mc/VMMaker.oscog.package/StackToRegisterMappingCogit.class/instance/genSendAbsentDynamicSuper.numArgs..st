bytecode generators
genSendAbsentDynamicSuper: selector numArgs: numArgs
	<inline: false>
	self marshallAbsentReceiverSendArguments: numArgs.
	^self genMarshalledSend: selector numArgs: numArgs sendTable: dynamicSuperSendTrampolines