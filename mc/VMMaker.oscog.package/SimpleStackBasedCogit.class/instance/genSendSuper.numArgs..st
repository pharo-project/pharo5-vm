bytecode generators
genSendSuper: selector numArgs: numArgs
	<inline: false>
	^self genSend: selector numArgs: numArgs sendTable: superSendTrampolines