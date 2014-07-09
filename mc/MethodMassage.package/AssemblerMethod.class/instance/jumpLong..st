assembling
jumpLong: label
	self checkLabel: label.
	self ensureInstructions addLast: (Message
										selector: #jumpLong:
										argument: label)