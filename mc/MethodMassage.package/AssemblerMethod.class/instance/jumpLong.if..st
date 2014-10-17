assembling
jumpLong: label if: cond
	self checkLabel: label.
	self ensureInstructions addLast: (Message
										selector: #jumpLong:if:
										arguments: {label. cond})