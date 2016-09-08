abstract instructions
MoveUniqueC32: wordConstant R: reg
	"Generate a MoveC32R instruction to move a 32-bit constant into a register.
	 If the backEnd is using out-of-line literals then those for inline caches cannot be shared,
	 and this method ensures the instruction has its own unique label.  If the backEnd is using
	 in-line literals then the literal is unique anyway and this is equivalent to MoveC32:R:.
	 If this is a 32-bit platform, simply generate a MoveCwR instruction, to avoid
	 needless duplication in the 32-bit code generators.."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self
		gen: (objectMemory wordSize = 8
				ifTrue: [MoveC32R]
				ifFalse: [MoveCwR])
		uniqueLiteral: wordConstant
		operand: reg