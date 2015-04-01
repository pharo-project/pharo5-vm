bytecode generators
genSendAbsentDynamicSuper: selector numArgs: numArgs
	"Shuffle arguments if necessary and push receiver.
	 Then send."
	<inline: false>
	self marshallAbsentReceiverSendArguments: numArgs.
	^self genSend: selector numArgs: numArgs sendTable: dynamicSuperSendTrampolines