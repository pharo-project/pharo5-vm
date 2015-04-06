bytecode generators
genSendAbsentOuter: selector numArgs: numArgs depth: depth
	<inline: false>
	^self
		genSendAbsentImplicitOrOuter: selector
		numArgs: numArgs
		depth: depth
		sendTable: outerSendTrampolines