initialization
reinitializeOpcode
	<inline: true>
	annotation := nil.
	dependent := nil.
	operands at: 0 put: (operands at: 1 put: (operands at: 2 put: 0))