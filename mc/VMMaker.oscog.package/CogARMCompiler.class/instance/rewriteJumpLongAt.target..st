inline cacheing
rewriteJumpLongAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a long jump instruction to jump to a different target.  This variant
	 is used to rewrite cached primitive calls.   Answer the extent of the
	 code change which is used to compute the range of the icache to flush."
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	"cogit disassembleFrom: callSiteReturnAddress - 40 to: callSiteReturnAddress + 9"

	"check that the instruction involved is actually a long jump BX"
	self assert: (objectMemory longAt:  callSiteReturnAddress - 4) = 16rE12FFF1A .
	
	"The callTargetAddress is loaded byte by byte."
	objectMemory byteAt: callSiteReturnAddress - 20 put: (callTargetAddress >> 24 bitAnd: 16rFF).
	objectMemory byteAt: callSiteReturnAddress - 16 put: (callTargetAddress >> 16 bitAnd: 16rFF).
	objectMemory byteAt: callSiteReturnAddress - 12 put: (callTargetAddress >> 8 bitAnd: 16rFF).
	objectMemory byteAt: callSiteReturnAddress - 8 put: (callTargetAddress  bitAnd: 16rFF).

	self assert: (self callTargetFromReturnAddress: callSiteReturnAddress) signedIntToLong = callTargetAddress.
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 20 to: callSiteReturnAddress - 1]."
	^20