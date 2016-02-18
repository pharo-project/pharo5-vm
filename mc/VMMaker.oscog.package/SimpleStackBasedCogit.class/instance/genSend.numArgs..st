bytecode generator support
genSend: selectorIndex numArgs: numArgs
	<inline: true>
	^self genSend: selectorIndex numArgs: numArgs sendTable: ordinarySendTrampolines