bytecode generators
genSendAbsentOuter: selectorIndex numArgs: numArgs depth: depth
	<inline: false>
	^self
		genNSSend: selectorIndex
		numArgs: numArgs
		depth: depth
		sendTable: outerSendTrampolines