abstract instructions
CmpC32: wordConstant R: reg
	"Generate a CmpC32R instruction to compare a 32-bit constant with a
	 register.  If this is a 32-bit platform, simply generate a CmpCwR instruction,
	 to avoid needless duplication in the 32-bit code generators.."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self
		gen: (objectMemory wordSize = 8
				ifTrue: [CmpC32R]
				ifFalse: [CmpCwR])
		literal: wordConstant
		operand: reg