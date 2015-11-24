inline cacheing
rewriteITypeBranchAtAddress: mcpc target: newTarget
	| newDisplacement oldInstruction newInstruction |	
	newDisplacement := newTarget - (mcpc - 4). "Displacement relative to delay slot"
	newDisplacement := newDisplacement >> 2.
	
	self assert: (newDisplacement between: -16r8000 and: 16r7FFF).
	newDisplacement < 0
		ifTrue: [newDisplacement := newDisplacement + 16r10000]
		ifFalse: [newDisplacement := newDisplacement].
	self assert: (newDisplacement between: 0 and: 16rFFFF).

	oldInstruction := objectMemory longAt: mcpc.
	newInstruction := (oldInstruction bitAnd: 16rFFFF0000) bitOr: newDisplacement.
	
	objectMemory longAt: mcpc put: newInstruction.