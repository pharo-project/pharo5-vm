inline cacheing
rewriteInlineCacheAt: callSiteReturnAddress tag: cacheTag target: callTargetAddress
	"Rewrite an inline cache to call a different target for a new tag.  This variant is used
	 to link unlinked sends in ceSend:to:numArgs: et al.  Answer the extent of the code
	 change which is used to compute the range of the icache to flush."
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	| call callDistance |
	false
		ifTrue: [self assert: callTargetAddress >= cogit minCallAddress]
		ifFalse: [callTargetAddress >= cogit minCallAddress ifFalse:
					[self error: 'linking callsite to invalid address']].
	callDistance := (callTargetAddress - (callSiteReturnAddress + 8 "pc offset"- 4 "return offset")) signedIntToLong.
	self assert: (self isInImmediateJumpRange: callDistance). "we don't support long call updates here"
	call := self bl: callDistance.
	objectMemory longAt: (self instructionAddressBefore: callSiteReturnAddress ) put: call.
	self insert32BitOperand: cacheTag into4InstructionsPreceding: (self instructionAddressBefore: callSiteReturnAddress ).
	self assert: (self callTargetFromReturnAddress: callSiteReturnAddress) = callTargetAddress.
	self assert: (self extract32BitOperandFrom4InstructionsPreceding: (self instructionAddressBefore: callSiteReturnAddress )) = cacheTag.
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 20 to: callSiteReturnAddress - 1]."
	^20