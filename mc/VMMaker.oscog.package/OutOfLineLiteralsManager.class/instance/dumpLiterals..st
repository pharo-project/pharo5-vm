compile abstract instructions
dumpLiterals: generateBranchAround
	"Output all pending literal instructions, making the originals dependents of the generated ones
	 so that a later pass will copy the address of each generated literl inst to its original in literals,
	 and hence allow the instruction using the literal to compute the correct address.."
	| jump litInst |
	<var: 'jump' type: #'AbstractInstruction *'>
	<var: 'litInst' type: #'AbstractInstruction *'>

	generateBranchAround ifTrue:
		[jump := cogit Jump: 0].
	lastDumpedLiteralIndex to: nextLiteralIndex - 1 do:
		[:i|
		litInst := self literalInstructionAt: i.
		(cogit gen: Literal operand: (litInst operands at: 0)) dependent: litInst.
		litInst setLiteralOpcodeIndex: cogit getOpcodeIndex].
	generateBranchAround ifTrue:
		[jump jmpTarget: cogit Label].

	firstOpcodeIndex := cogit getOpcodeIndex.
	lastDumpedLiteralIndex := nextLiteralIndex