inline cacheing
rewriteJTypeAtAddress: mcpc target: newTarget
	| regionMask |
	regionMask := 16rF0000000.
	"mcpc + 4: relative to delay slot not j"
	self assert: (mcpc + 4 bitAnd: regionMask) = (newTarget bitAnd: regionMask).
	objectMemory longAt: mcpc put: (self jA: newTarget).