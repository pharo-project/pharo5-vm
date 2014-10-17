assembling
jump: label if: cond
	self checkLabel: label.
	self ensureInstructions addLast: (Message
										selector: #jump:if:
										arguments: {label. cond})