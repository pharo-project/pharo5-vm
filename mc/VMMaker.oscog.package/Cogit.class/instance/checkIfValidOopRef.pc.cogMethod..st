garbage collection
checkIfValidOopRef: annotation pc: mcpc cogMethod: cogMethod
	<var: #mcpc type: #'char *'>
	annotation = IsObjectReference ifTrue:
		[| literal |
		 literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 (objectRepresentation checkValidOopReference: literal) ifFalse:
			[coInterpreter print: 'object ref leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
			^1]].
	(self isSendAnnotation: annotation) ifTrue:
		[| entryPoint selectorOrCacheTag offset |
		 entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint <= methodZoneBase
			ifTrue:
				[offset := entryPoint]
			ifFalse:
				[self
					offsetAndSendTableFor: entryPoint
					annotation: annotation
					into: [:off :table| offset := off]].
		 selectorOrCacheTag := backEnd inlineCacheTagAt: mcpc asInteger.
		 (entryPoint > methodZoneBase
		  and: [offset ~= cmNoCheckEntryOffset
		  and: [(self cCoerceSimple: entryPoint - offset to: #'CogMethod *') cmType ~= CMOpenPIC]])
			ifTrue: "linked non-super send, cacheTag is a cacheTag"
				[(objectRepresentation checkValidInlineCacheTag: selectorOrCacheTag) ifFalse:
					[coInterpreter print: 'cache tag leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
					^1]]
			ifFalse: "unlinked send or super send; cacheTag is a selector"
				[(objectRepresentation checkValidOopReference: selectorOrCacheTag) ifFalse:
					[coInterpreter print: 'selector leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
					^1]]].
	^0 "keep scanning"