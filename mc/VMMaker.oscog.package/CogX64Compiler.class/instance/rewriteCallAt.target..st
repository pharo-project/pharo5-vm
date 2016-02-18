inline cacheing
rewriteCallAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a call instruction to call a different target.  This variant is used to link PICs
	 in ceSendMiss et al, and to rewrite cached primitive calls.   Answer the extent of
	 the code change which is used to compute the range of the icache to flush."
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	| callDistance |
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 10 to: callSiteReturnAddress - 1]."
	false
		ifTrue: [self assert: callTargetAddress >= cogit minCallAddress]
		ifFalse: [callTargetAddress >= cogit minCallAddress ifFalse:
					[self error: 'linking callsite to invalid address']].
	callDistance := (callTargetAddress - callSiteReturnAddress) signedIntToLong.
	objectMemory
		byteAt: callSiteReturnAddress - 1 put: (callDistance >> 24 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 2 put: (callDistance >> 16 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 3 put: (callDistance >>   8 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 4 put: (callDistance            bitAnd: 16rFF).
	self assert: (self callTargetFromReturnAddress: callSiteReturnAddress) = callTargetAddress.
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 10 to: callSiteReturnAddress - 1]."
	^5