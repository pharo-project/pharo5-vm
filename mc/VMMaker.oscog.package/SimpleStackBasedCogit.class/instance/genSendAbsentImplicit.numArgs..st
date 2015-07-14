bytecode generators
genSendAbsentImplicit: selector numArgs: numArgs
	<inline: false>
	^self
		genNSSend: selector
		numArgs: numArgs
		depth: LookupRuleImplicit
		sendTable: implicitReceiverSendTrampolines