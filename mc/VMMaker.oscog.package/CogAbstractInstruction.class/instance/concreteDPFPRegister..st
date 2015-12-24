encoding
concreteDPFPRegister: reg
	<inline: true>
	self cCode: [] inSmalltalk: [self assert: reg isInteger].
	^reg