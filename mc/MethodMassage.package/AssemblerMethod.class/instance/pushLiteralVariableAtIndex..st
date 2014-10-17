assembling
pushLiteralVariableAtIndex: litIndex
	self ensureInstructions addLast: (Message
										selector: #pushLiteralVariableAtIndex:
										argument: litIndex)