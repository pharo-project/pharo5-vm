inline cacheing
rewriteConditionalJumpLongAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a jump instruction to call a different target.  This variant is used to reset the 
	jumps in the prototype CPIC to suit each use,.   
	Answer the extent of the code change which is used to compute the range of the icache to flush."
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 8) = J.
	self assert: (objectMemory longAt: callSiteReturnAddress - 4) = self nop.
	"cogit disassembleFrom: callSiteReturnAddress - 8 to: callSiteReturnAddress."

	self rewriteJTypeAtAddress: callSiteReturnAddress - 8 target: callTargetAddress.

	self assert: (self opcodeAtAddress: callSiteReturnAddress - 8) = J.
	self assert: (objectMemory longAt: callSiteReturnAddress - 4) = self nop.
	"cogit disassembleFrom: callSiteReturnAddress - 8 to: callSiteReturnAddress."
