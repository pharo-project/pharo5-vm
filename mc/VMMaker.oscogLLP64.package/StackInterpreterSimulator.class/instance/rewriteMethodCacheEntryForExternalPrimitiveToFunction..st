method lookup cache
rewriteMethodCacheEntryForExternalPrimitiveToFunction: localPrimAddress
	self assert: (localPrimAddress isSymbol
			or: [localPrimAddress isInteger
				and: [localPrimAddress = 0
					or: [(localPrimAddress between: 256 and: 519)
					or: [localPrimAddress > 1000]]]]).
	^super rewriteMethodCacheEntryForExternalPrimitiveToFunction: localPrimAddress