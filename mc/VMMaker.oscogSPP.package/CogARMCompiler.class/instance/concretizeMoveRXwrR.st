generate machine code - concretize
concretizeMoveRXwrR
	"Will get inlined into concretizeAt: switch."
	"Write the word in R(src) into memory at address (base+4*index)"
	<inline: true>
	| index base src |
	src := operands at: 0.
	index := operands at: 1. "index is number of *words* = 4* bytes"
	base := operands at: 2.
	"str		src, [base, +index, LSL #2]"
	"cond 011 1100 0 base srcR 00010 00 0 inde"
	self machineCodeAt: 0 put: (self memMxr: AL reg: src base: base p: 1 u: 1 b: 0 w: 0 l: 0 rmLsl2: index).
	^machineCodeSize := 4