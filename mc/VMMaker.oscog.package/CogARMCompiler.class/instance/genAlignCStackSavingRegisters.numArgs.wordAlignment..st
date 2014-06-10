abi
genAlignCStackSavingRegisters: saveRegs numArgs: numArgs wordAlignment: alignment 
	"ARM needs 8 byte stack alignment but it's hard to be sure where the stack is at this
	 point due to the complexities of whether we push the return address or not.  So do
	 a simple bitAnd to effectively round-down the SP - except the vagaries of the ARM
	 instruction set means we actually need a BIC sp, sp, $7"

	cogit gen: BICCqR operand: 2r111 operand: SPReg.
	^0