generate machine code - concretize
concretizeMoveXwrRR
	"Will get inlined into concretizeAt: switch."
	
	<inline: true>
	| index base dest |
	index := operands at: 0.
	base := operands at: 1.
	dest := operands at: 2.
	"LDR	dest, [base, +index, LSL #2]"
	"cond 011 1100 1 base dest 00010 00 0 inde bulit by lowest level generator so we can do the lsl #2 on the index register"
	self machineCodeAt: 0 put: (self memMxr: AL reg: dest base: base p: 1 u: 1 b: 0 w: 0 l: 1 rmLsl2: index).
	^machineCodeSize := 4