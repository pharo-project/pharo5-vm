compile abstract instructions
genJumpInOldSpace: reg
	"Jump if reg is old."
	<inline: true>
	^cogit
		MoveAw: objectMemory youngStartAddress R: TempReg;
		CmpR: TempReg R: reg;	"N.B. FLAGS := destReg - scratchReg"
		JumpBelow: 0