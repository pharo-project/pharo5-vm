debugging
checkEnoughOpcodes
	<inline: true>
	opcodeIndex > numAbstractOpcodes ifTrue:
		[self error: 'Cog JIT internal error. Too many abstract opcodes.  Num opcodes heuristic is too optimistic.']