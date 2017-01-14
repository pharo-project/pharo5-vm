generate machine code - concretize
concretizePushR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg |
	srcReg := operands at: 0.
	"cond | 010 | 1001 | 0 | -Rn- | -Rd- | 0000 0000 0100" "STR srcReg, [sp, #-4]"
	self machineCodeAt: 0 put: (self pushR: srcReg).
	^machineCodeSize := 4