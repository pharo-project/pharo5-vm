bytecode generator support
genSend: selector numArgs: numArgs
	<inline: true>
	^self genSend: selector numArgs: numArgs sendTable: ordinarySendTrampolines