abstract instructions
genSwapR: regA R: regB Scratch: regTmp
	"Generic register swap code.  Subclasses for processors that have a true exchange operation will override to use it."
	| first |
	<var: 'first' type: #'AbstractInstruction *'>
	first :=
	cogit MoveR: regA R: regTmp.
	cogit MoveR: regB R: regA.
	cogit MoveR: TempReg R: regB.
	^first