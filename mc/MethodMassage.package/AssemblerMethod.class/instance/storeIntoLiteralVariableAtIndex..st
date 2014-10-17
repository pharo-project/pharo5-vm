assembling
storeIntoLiteralVariableAtIndex: litIndex
	self ensureInstructions addLast: (Message
										selector: #storeIntoLiteralVariableAtIndex:
										argument: litIndex)