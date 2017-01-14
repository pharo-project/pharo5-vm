disassembly
isJumpAt: pc
	| op |
	op := objectMemory byteAt: pc.
	^  (op between: 16r70 and: 16r7F) "short conditional jumps"
	or: [op = 16rE9 "long unconditional jump"
	or: [op = 16rEB "short unconditional jump"
	or: [(op = 16r0F "long conditional jumps"
		and: [(objectMemory byteAt: pc + 1) between: 16r80 and: 16r8F])
	or: [op = 16r48 "full unconditional jumps"
		and: [(objectMemory byteAt: pc + 1) = 16rA1
		and: [(objectMemory byteAt: pc + 10) = 16rFF
		and: [(objectMemory byteAt: pc + 11) = 16rE0]]]]]]]