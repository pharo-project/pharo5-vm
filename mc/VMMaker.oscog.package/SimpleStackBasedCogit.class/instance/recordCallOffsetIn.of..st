external primitive support
recordCallOffsetIn: cogMethod of: callLabelArg
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	<var: #callLabelArg type: #'void *'>
	| callLabel offset offsetTable |
	<var: #callLabel type: #'AbstractInstruction *'>
	<var: #offsetTable type: #'sqInt *'>
	callLabel := callLabelArg. "this function is exported but AbstractInstruction isn't; hence pun through void *"
	offsetTable := (backEnd isCallPreceedingReturnPC: callLabel address asUnsignedInteger)
						ifTrue: [externalPrimCallOffsets]
						ifFalse: [externalPrimJumpOffsets].
	offset := callLabel address - cogMethod asInteger.
	(offsetTable at: cogMethod cmNumArgs) isNil
		ifTrue: [offsetTable at: cogMethod cmNumArgs put: offset]
		ifFalse: [self assert: (offsetTable at: cogMethod cmNumArgs) = offset]