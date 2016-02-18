inline cacheing
rewriteITypeBranchAtAddress: mcpc target: newTarget
	| newDisplacement oldInstruction newInstruction |
	newDisplacement := newTarget - (mcpc + 4). "Displacement is relative to delay slot."
	newDisplacement := newDisplacement >>> 2. "Displacement is in words."
	newDisplacement := (newDisplacement bitAnd: 16rFFFF).

	oldInstruction := objectMemory longAt: mcpc.
	newInstruction := (oldInstruction bitAnd: 16rFFFF0000) bitOr: newDisplacement.
	
	objectMemory longAt: mcpc put: newInstruction.