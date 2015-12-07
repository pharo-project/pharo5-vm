full transfer run-time support
rewriteCallFullAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a CallFull instruction to call a different target.  This variant is used to rewrite cached primitive calls.
	 Answer the extent of the code change which is used to compute the range of the icache to flush.
	 On x64 this is a rewrite of
		movq #64bits, %rax : 48 A1 b0 b1 b2 b3 b4 b5 b6 b7
		jmp %rax : FF E0 "
	self assert: (objectMemory byteAt: callSiteReturnAddress - 12) = 16r48.
	objectMemory
		byteAt: callSiteReturnAddress -   3 put: (callTargetAddress >> 56 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress -   4 put: (callTargetAddress >> 48 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress -   5 put: (callTargetAddress >> 40 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress -   6 put: (callTargetAddress >> 32 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress -   7 put: (callTargetAddress >> 24 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress -   8 put: (callTargetAddress >> 16 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress -   9 put: (callTargetAddress >>   8 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 10 put: (callTargetAddress            bitAnd: 16rFF).
	self assert: (self callFullTargetFromReturnAddress: callSiteReturnAddress) signedIntToLong64 = callTargetAddress.
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 10 to: callSiteReturnAddress - 1]."
	^12