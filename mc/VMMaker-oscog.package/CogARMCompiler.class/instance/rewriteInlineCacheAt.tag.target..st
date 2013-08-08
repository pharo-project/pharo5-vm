inline cacheing
rewriteInlineCacheAt: callSiteReturnAddress tag: cacheTag target: callTargetAddress
	"Rewrite an inline cache to call a different target for a new tag.  This variant is used
	 to link unlinked sends in ceSend:to:numArgs: et al.  Answer the extent of the code
	 change which is used to compute the range of the icache to flush."
	
	"chacheTag contains an oop to the selector which need be loaded before jumping"
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	| call callDistance |
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 20 to: callSiteReturnAddress -1]."
	false
		ifTrue: [self assert: callTargetAddress >= cogit minCallAddress]
		ifFalse: [callTargetAddress >= cogit minCallAddress ifFalse:
					[self error: 'linking callsite to invalid address']].
	callDistance := (callTargetAddress - (callSiteReturnAddress + 8 "pc offset"- 4 "return offset")) signedIntToLong.
	
	self assert: (self isQuick: callDistance). "we don't support long call updates, yet"
	call := (self t: 5 o: 8)"BL" + (callDistance >> 2 bitAnd: 16rFFFFFF).
	objectMemory
		byteAt: callSiteReturnAddress - 1 put: (call >> 24 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 2 put: (call >> 16 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 3 put: (call >>   8 bitAnd: 16rFF);
		byteAt: callSiteReturnAddress - 4 put: (call            bitAnd: 16rFF).
	
	"The cacheTag is loaded byte by byte. Each byte needs to be encoded with minimal right ring rotation. See also #at:moveCw:intoR:"
	-20 to: -8 by: 4 do: [ :offset || rotation |
		rotation := self minimalRightRingRotationFor: cacheTag initialRotation: (offset + 8) negated.
		(offset + 8) ~= 0 ifTrue: [ "in case of decoration which may change the last instrution, we should not overwrite bits 9 to 12"
			objectMemory 
				byteAt: callSiteReturnAddress + offset + 1 
				put: (((objectMemory byteAt: callSiteReturnAddress - offset + 1) 
							bitAnd: 16rF0)
						bitOr: (rotation at: 1))].
		objectMemory
			byteAt: callSiteReturnAddress + offset
			put: (rotation at: 2)].

	self assert: (self callTargetFromReturnAddress: callSiteReturnAddress) signedIntToLong = callTargetAddress.
	"self cCode: ''
		inSmalltalk: [cogit disassembleFrom: callSiteReturnAddress - 20 to: callSiteReturnAddress - 1]."
	^20