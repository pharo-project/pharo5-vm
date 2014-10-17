assembling
popIntoLiteralVariableAtIndex: litIndex
	self ensureInstructions addLast: (Message
										selector: #popIntoLiteralVariableAtIndex:
										argument: litIndex)