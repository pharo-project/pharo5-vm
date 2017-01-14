bytecode generator support
genSendSuper: selectorIndex numArgs: numArgs
	<inline: false>
	^self genSend: selectorIndex numArgs: numArgs sendTable: superSendTrampolines