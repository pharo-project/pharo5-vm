generate machine code
resolveJumpTarget
	<var: #fixup type: #'BytecodeFixup *'>
	| fixup |
	self assert: self isJump.
	fixup := cogit cCoerceSimple: (operands at: 0) to: #'BytecodeFixup *'.
	self cCode: [] inSmalltalk:
		[(fixup isKindOf: CogBytecodeFixup) ifTrue:
			[self assert: (self isAFixup: fixup)]].
	(self isAFixup: fixup) ifTrue:
		[self assert: (cogit addressIsInInstructions: fixup targetInstruction).
		 self jmpTarget: fixup targetInstruction]