bytecode generator support
genSendDirectedSuper: selector numArgs: numArgs
	<inline: false>
	self halt: 'do all that good stuff moving the literal variable to an argument reg, etc...'.
	^self genSend: selector numArgs: numArgs sendTable: directedSuperSendTrampolines