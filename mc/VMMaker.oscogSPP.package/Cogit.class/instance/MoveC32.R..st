abstract instructions
MoveC32: wordConstant R: reg
	"Generate a MoveC32R instruction to move a 32-bit constant into a register.
	 If this is a 32-bit platform, simply generate a MoveCwR instruction, to avoid
	 needless duplication in the 32-bit code generators.."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self
		gen: (objectMemory wordSize = 8
				ifTrue: [MoveC32R]
				ifFalse: [MoveCwR])
		literal: wordConstant
		operand: reg