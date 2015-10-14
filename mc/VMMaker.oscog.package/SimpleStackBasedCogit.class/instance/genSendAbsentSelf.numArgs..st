bytecode generators
genSendAbsentSelf: selectorIndex numArgs: numArgs
	<inline: false>
	^self
		genNSSend: selectorIndex
		numArgs: numArgs
		depth: LookupRuleSelf
		sendTable: selfSendTrampolines