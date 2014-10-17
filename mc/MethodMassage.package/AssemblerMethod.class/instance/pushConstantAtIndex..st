assembling
pushConstantAtIndex: litIndex
	self ensureInstructions addLast: (Message
										selector: #pushConstantAtIndex:
										argument: litIndex)