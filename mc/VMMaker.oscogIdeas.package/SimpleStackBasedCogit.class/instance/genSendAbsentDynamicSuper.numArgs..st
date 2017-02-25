bytecode generators
genSendAbsentDynamicSuper: selectorIndex numArgs: numArgs
	<inline: false>
	^self
		genNSSend: selectorIndex
		numArgs: numArgs
		depth: LookupRuleDynamicSuper
		sendTable: dynamicSuperSendTrampolines