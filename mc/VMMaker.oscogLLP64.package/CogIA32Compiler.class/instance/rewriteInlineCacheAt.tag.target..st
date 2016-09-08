inline cacheing
rewriteInlineCacheAt: callSiteReturnAddress tag: cacheTag target: callTargetAddress
	"Rewrite an inline cache to call a different target for a new tag.  This variant is used
	 to link unlinked sends in ceSend:to:numArgs: et al.  Answer the extent of the code
	 change which is used to compute the range of the icache to flush."
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
		byteAt: callSiteReturnAddress - 4 put: (callDistance            bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 6 put: (cacheTag >> 24 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 7 put: (cacheTag >> 16 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 8 put: (cacheTag >>   8 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 9 put: (cacheTag            bitAnd: 16rFF).
	self assert: (self callTargetFromReturnAddress: callSiteReturnAddress) = callTargetAddress.
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 10 to: callSiteReturnAddress - 1]."
	^10