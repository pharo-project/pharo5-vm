garbage collection
checkIfValidOopRef: annotation pc: mcpc cogMethod: cogMethod
	"Check for a valid object reference, if any, at a map entry.  Answer a code unique to each error for debugging."
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	annotation = IsObjectReference ifTrue:
		[| literal |
		 literal := literalsManager fetchLiteralAtAnnotatedAddress: mcpc asUnsignedInteger using: backEnd.
		 (objectRepresentation checkValidOopReference: literal) ifFalse:
			[coInterpreter print: 'object ref leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
			^1]].

	NewspeakVM ifTrue:
		[annotation = IsNSSendCall ifTrue:
			[| nsSendCache enclosingObject |
			nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
			[(objectRepresentation checkValidOopReference: nsSendCache selector) ifFalse:
				[coInterpreter print: 'selector leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
				^1]].
			(enclosingObject := nsSendCache enclosingObject) ~= 0 ifTrue:
				[[(objectRepresentation checkValidOopReference: enclosingObject) ifFalse:
					[coInterpreter print: 'enclosing object leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
					^1]]]]].

	(self isPureSendAnnotation: annotation) ifTrue:
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
			ifFalse: "unlinked send or super send; cacheTag is a selector unless 64-bit, in which case it is an index."
				[(self inlineCacheTagsAreIndexes
				  or: [objectRepresentation checkValidOopReference: selectorOrCacheTag]) ifFalse:
					[coInterpreter print: 'selector leak in CM '; printHex: cogMethod asInteger; print: ' @ '; printHex: mcpc asInteger; cr.
					^1]]].
	^0 "keep scanning"