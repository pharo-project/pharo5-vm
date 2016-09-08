compile abstract instructions
genJumpInOldSpace: reg
	"Jump if reg is old."
	<inline: true>
	^cogit
		CmpCq: objectMemory storeCheckBoundary R: reg; "N.B. FLAGS := destReg - scratchReg"
		JumpAboveOrEqual: 0