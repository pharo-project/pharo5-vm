abstract instructions
MoveUniqueCw: wordConstant R: reg
	"If the backEnd is using out-of-line literals then those for inline caches cannot be shared, and
	 this method ensures the instruction has its own unique label.  If the backEnd is using
	 in-line literals then the literal is unique anyway and this is equivalent to MoveCw:R:"
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveCwR uniqueLiteral: wordConstant operand: reg