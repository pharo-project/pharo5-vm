debug support
sendBreak: selectorString point: selectorLength receiver: receiverOrNil
	<doNotGenerate> "C version is in platforms/Cross/vm/dispdbg.h"
	"self shortPrintFrameAndCallers: localFP"
	| i |
	breakSelectorLength = selectorLength ifTrue:
		[i := breakSelectorLength.
		 [i > 0] whileTrue:
			[(objectMemory byteAt: selectorString + i - 1) = (breakSelector at: i) asInteger
				ifTrue: [(i := i - 1) = 0 ifTrue:
							[self changed: #byteCountText.
							 self halt: 'Send of '
									, breakSelector,
									(receiverOrNil
										ifNotNil: [' to ', (self shortPrint: receiverOrNil)]
										ifNil: [''])]]
				ifFalse: [i := 0]]]