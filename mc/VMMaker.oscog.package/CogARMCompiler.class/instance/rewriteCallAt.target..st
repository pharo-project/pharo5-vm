inline cacheing
rewriteCallAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a call instruction to call a different target.  This variant is used to link PICs
	 in ceSendMiss et al, and to rewrite cached primitive calls.   Answer the extent of
	 the code change which is used to compute the range of the icache to flush."
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	| callDistance call |
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 10 to: callSiteReturnAddress - 1]."
	false
		ifTrue: [self assert: callTargetAddress >= cogit minCallAddress]
		ifFalse: [callTargetAddress >= cogit minCallAddress ifFalse:
					[self error: 'linking callsite to invalid address']].
	callDistance := (callTargetAddress - (callSiteReturnAddress + 8 "pc offset"- 4 "return offset")) signedIntToLong.
	self assert: (self isQuick: callDistance). "we don't support long call updates, yet"
	call := self cond: AL br: 1 offset: callDistance.
	objectMemory longAt:  callSiteReturnAddress - 4 put: call.

	self assert: (self callTargetFromReturnAddress: callSiteReturnAddress) signedIntToLong = callTargetAddress.
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 10 to: callSiteReturnAddress - 1]."
	^4