assembling
jump: label
	self checkLabel: label.
	self ensureInstructions addLast: (Message
										selector: #jump:
										argument: label)