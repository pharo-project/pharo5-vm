bytecode generators
genSendAbsentOuter: selector numArgs: numArgs depth: depth
	<inline: false>
	^self
		genNSSend: selector
		numArgs: numArgs
		depth: depth
		sendTable: outerSendTrampolines