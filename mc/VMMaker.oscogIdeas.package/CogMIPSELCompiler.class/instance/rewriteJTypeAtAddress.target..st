inline cacheing
rewriteJTypeAtAddress: mcpc target: newTarget
	| regionMask |
	self assert: (self opcodeAtAddress: mcpc) = J.
	regionMask := 16rF0000000.
	"mcpc + 4: relative to delay slot not j"
	self assert: (mcpc + 4 bitAnd: regionMask) = (newTarget bitAnd: regionMask).
	objectMemory longAt: mcpc put: (self jA: newTarget).