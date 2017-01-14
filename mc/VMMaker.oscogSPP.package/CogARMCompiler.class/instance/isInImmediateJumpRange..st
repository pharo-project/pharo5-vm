testing
isInImmediateJumpRange: operand
	"ARM calls and jumps span +/- 32 mb, more than enough for intra-zone calls and jumps."
	<var: #operand type: #'usqIntptr_t'>
	^operand signedIntFromLong between: -16r2000000 and: 16r1FFFFFC