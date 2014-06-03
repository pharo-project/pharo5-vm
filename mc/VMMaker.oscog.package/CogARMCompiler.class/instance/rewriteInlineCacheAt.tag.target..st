inline cacheing
rewriteInlineCacheAt: callSiteReturnAddress tag: cacheTag target: callTargetAddress
	"Rewrite an inline cache to call a different target for a new tag.  This variant is used
	 to link unlinked sends in ceSend:to:numArgs: et al.  Answer the extent of the code
	 change which is used to compute the range of the icache to flush."
	
	"chacheTag contains an oop to the selector which need be loaded before jumping"
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	| call callDistance |
	"cogit disassembleFrom: callSiteReturnAddress - 40 to: callSiteReturnAddress + 9"
	false
		ifTrue: [self assert: callTargetAddress >= cogit minCallAddress]
		ifFalse: [callTargetAddress >= cogit minCallAddress ifFalse:
					[self error: 'linking callsite to invalid address']].
	callDistance := (callTargetAddress - (callSiteReturnAddress + 8 "pc offset"- 4 "return offset")) signedIntToLong.
	
	self assert: (self isQuick: callDistance). "we don't support long call updates, yet"
	call := self cond: AL br: 1 offset: callDistance.
	objectMemory longAt:  callSiteReturnAddress - 4 put: call.
	
	"The cacheTag is loaded byte by byte. Each byte needs to be encoded with minimal right ring rotation. See also #at:moveCw:intoR:"
	objectMemory byteAt: callSiteReturnAddress - 20 put: (cacheTag >> 24 bitAnd: 16rFF).
	objectMemory byteAt: callSiteReturnAddress - 16 put: (cacheTag >> 16 bitAnd: 16rFF).
	objectMemory byteAt: callSiteReturnAddress - 12 put: (cacheTag >> 8 bitAnd: 16rFF).
	objectMemory byteAt: callSiteReturnAddress - 8 put: (cacheTag  bitAnd: 16rFF).

	self assert: (self callTargetFromReturnAddress: callSiteReturnAddress) signedIntToLong = callTargetAddress.
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 20 to: callSiteReturnAddress - 1]."
	^20