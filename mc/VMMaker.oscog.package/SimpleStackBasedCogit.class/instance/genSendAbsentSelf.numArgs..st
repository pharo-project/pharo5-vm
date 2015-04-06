bytecode generators
genSendAbsentSelf: selector numArgs: numArgs
	<inline: false>
	self marshallAbsentReceiverSendArguments: numArgs.
	^self genSend: selector numArgs: numArgs sendTable: selfSendTrampolines