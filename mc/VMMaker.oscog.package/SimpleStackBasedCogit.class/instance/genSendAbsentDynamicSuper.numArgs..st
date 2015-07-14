bytecode generators
genSendAbsentDynamicSuper: selector numArgs: numArgs
	<inline: false>
	^self
		genNSSend: selector
		numArgs: numArgs
		depth: LookupRuleDynamicSuper
		sendTable: dynamicSuperSendTrampolines