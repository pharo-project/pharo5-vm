bytecode generators
genSend: selector numArgs: numArgs
	<inline: true>
	^self genSend: selector numArgs: numArgs sendTable: ordinarySendTrampolines