debugging traps
sendBreak: selectorString point: selectorLength receiver: receiverOrNil
	"self shortPrintFrameAndCallers: localFP"
	| i |
	breakSelectorLength = selectorLength ifTrue:
		[i := breakSelectorLength.
		 [i > 0] whileTrue:
			[(self byteAt: selectorString + i - 1) = (breakSelector at: i) asInteger
				ifTrue: [(i := i - 1) = 0 ifTrue:
							[self halt: 'Send of '
									, breakSelector,
									(receiverOrNil
										ifNotNil: [' to ', (self shortPrint: receiverOrNil)]
										ifNil: [''])]]
				ifFalse: [i := 0]]]