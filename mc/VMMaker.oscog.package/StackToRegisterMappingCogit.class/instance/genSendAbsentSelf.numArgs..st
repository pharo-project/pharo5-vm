bytecode generators
genSendAbsentSelf: selector numArgs: numArgs
	<inline: false>
	self marshallAbsentReceiverSendArguments: numArgs.
	^self genMarshalledSend: selector numArgs: numArgs sendTable: selfSendTrampolines