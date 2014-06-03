garbage collection
checkIfValidOopRefAndTarget: annotation pc: mcpc cogMethod: cogMethod
	<var: #mcpc type: #'char *'>
	| literal entryPoint |
	annotation = IsObjectReference ifTrue:
		[literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 (self asserta: (objectRepresentation checkValidOopReference: literal)) ifFalse:
			[^1].
		((objectRepresentation couldBeObject: literal)
		 and: [objectMemory isReallyYoungObject: literal]) ifTrue:
			[(self asserta: (self cCoerceSimple: cogMethod to: #'CogMethod *') cmRefersToYoung) ifFalse:
				[^2]]].
	(self isSendAnnotation: annotation) ifTrue:
		[(self asserta: (self cCoerceSimple: cogMethod to: #'CogMethod *') cmType = CMMethod) ifFalse:
			[^3].
		 self offsetCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:offset :cacheTag :tagCouldBeObject|
			tagCouldBeObject
				ifTrue:
					[(objectRepresentation couldBeObject: cacheTag)
						ifTrue:
							[(self asserta: (objectRepresentation checkValidOopReference: cacheTag)) ifFalse:
								[^4]]
						ifFalse:
							[(self asserta: (objectRepresentation checkValidInlineCacheTag: cacheTag)) ifFalse:
								[^5]].
					((objectRepresentation couldBeObject: cacheTag)
					 and: [objectMemory isReallyYoungObject: cacheTag]) ifTrue:
						[(self asserta: (self cCoerceSimple: cogMethod to: #'CogMethod *') cmRefersToYoung) ifFalse:
							[^6]]]
				ifFalse:
					[(self asserta: (objectRepresentation checkValidInlineCacheTag: cacheTag)) ifFalse:
						[^7]]].
		entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		entryPoint > methodZoneBase ifTrue:
			["It's a linked send; find which kind."
			 self targetMethodAndSendTableFor: entryPoint into:
					[:targetMethod :sendTable|
					 (self asserta: (targetMethod cmType = CMMethod
								   or: [targetMethod cmType = CMClosedPIC
								   or: [targetMethod cmType = CMOpenPIC]])) ifFalse:
						[^8]]]].
	^0 "keep scanning"