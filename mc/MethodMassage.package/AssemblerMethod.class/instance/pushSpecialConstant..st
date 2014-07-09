assembling
pushSpecialConstant: aConstant
	self ensureInstructions addLast: (Message
										selector: #pushSpecialConstant:
										argument: aConstant)