bytecode generators
genSendAbsentImplicit: selector numArgs: numArgs
	<inline: false>
	^self
		genSendAbsentImplicitOrOuter: selector
		numArgs: numArgs
		depth: 255 "Unused"
		sendTable: implicitReceiverSendTrampolines