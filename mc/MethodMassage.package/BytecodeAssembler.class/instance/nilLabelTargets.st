assembly
nilLabelTargets
	code instructions do:
		[:messageOrLabel|
		(self isLabel: messageOrLabel) ifTrue:
			[messageOrLabel value: nil]]