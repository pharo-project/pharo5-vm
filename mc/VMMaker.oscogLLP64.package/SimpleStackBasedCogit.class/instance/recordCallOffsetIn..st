external primitive support
recordCallOffsetIn: cogMethod
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	| offset offsetTable |
	<var: #offsetTable type: #'sqInt *'>
	offset := primSetFunctionLabel address - cogMethod asInteger.
	(externalSetPrimOffsets at: cogMethod cmNumArgs) isNil
		ifTrue: [externalSetPrimOffsets at: cogMethod cmNumArgs put: offset]
		ifFalse: [self assert: (externalSetPrimOffsets at: cogMethod cmNumArgs) = offset].
	offsetTable := primInvokeInstruction isJump
						ifTrue: [externalPrimJumpOffsets]
						ifFalse: [externalPrimCallOffsets].
	offset := primInvokeInstruction address + primInvokeInstruction machineCodeSize - cogMethod asInteger.
	(offsetTable at: cogMethod cmNumArgs) isNil
		ifTrue: [offsetTable at: cogMethod cmNumArgs put: offset]
		ifFalse: [self assert: (offsetTable at: cogMethod cmNumArgs) = offset]