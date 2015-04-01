garbage collection
checkIfValidOopRef: annotation pc: mcpc cogMethod: cogMethod
	| nsSendCache |
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	annotation = IsObjectReference ifTrue:
		[| literal |
		 literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 (objectRepresentation checkValidOopReference: literal) ifFalse:
			[coInterpreter print: 'object ref leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
			^1]].

	self cppIf: NewspeakVM ifTrue: [annotation = IsNSSendCall ifTrue:
		[ | enclosingObject |
		nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
		[(objectRepresentation checkValidOopReference: nsSendCache selector) ifFalse:
			[coInterpreter print: 'selector leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
			^1]].
		(enclosingObject := nsSendCache enclosingObject) ~= 0 ifTrue:
			[[(objectRepresentation checkValidOopReference: enclosingObject) ifFalse:
				[coInterpreter print: 'enclosing object leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
				^1]]]]].

	annotation = IsSendCall ifTrue:
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
				[(objectRepresentation validInlineCacheTag: selectorOrCacheTag) ifFalse:
					[coInterpreter print: 'cache tag leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
					^1]]
			ifFalse: "unlinked send or super send; cacheTag is a selector"
				[(objectRepresentation checkValidOopReference: selectorOrCacheTag) ifFalse:
					[coInterpreter print: 'selector leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
					^1]]].
	^0 "keep scanning"