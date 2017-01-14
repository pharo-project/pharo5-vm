bytecode generators
genSendAbsentImplicit: selectorIndex numArgs: numArgs
	<inline: false>
	^self
		genNSSend: selectorIndex
		numArgs: numArgs
		depth: LookupRuleImplicit
		sendTable: implicitReceiverSendTrampolines