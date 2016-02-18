inline cacheing
rewriteFullTransferAt: callSiteReturnAddress target: callTargetAddress expectedInstruction: expectedInstruction
	"Rewrite a CallFull or JumpFull instruction to transfer to a different target.
	 This variant is used to rewrite cached primitive calls.   Answer the extent
	 of the code change which is used to compute the range of the icache to flush."
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	"cogit disassembleFrom: callSiteReturnAddress - 20 to: callSiteReturnAddress - 1"
	self assert: (self instructionBeforeAddress: callSiteReturnAddress) = expectedInstruction.
	self insert32BitOperand: callTargetAddress into4InstructionsPreceding: callSiteReturnAddress - 4.
	self assert: (self callFullTargetFromReturnAddress: callSiteReturnAddress) signedIntToLong = callTargetAddress.
	^20