bytecode generators
genSendAbsentSelf: selector numArgs: numArgs
	<inline: false>
	^self
		genNSSend: selector
		numArgs: numArgs
		depth: LookupRuleSelf
		sendTable: selfSendTrampolines