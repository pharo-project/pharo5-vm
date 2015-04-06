bytecode generators
genSendAbsentDynamicSuper: selector numArgs: numArgs
	<inline: false>
	self marshallAbsentReceiverSendArguments: numArgs.
	^self genSend: selector numArgs: numArgs sendTable: dynamicSuperSendTrampolines