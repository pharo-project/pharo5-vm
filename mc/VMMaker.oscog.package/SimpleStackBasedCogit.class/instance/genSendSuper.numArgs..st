bytecode generator support
genSendSuper: selector numArgs: numArgs
	<inline: false>
	^self genSend: selector numArgs: numArgs sendTable: superSendTrampolines