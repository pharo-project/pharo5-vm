garbage collection
checkIfValidObjectRefAndTarget: annotation pc: mcpc cogMethod: cogMethod
	<var: #mcpc type: #'char *'>
	| literal cacheTag entryPoint offset targetMethod |
	<var: #targetMethod type: #'CogMethod *'>
	annotation = IsObjectReference ifTrue:
		[literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 (self asserta: (objectRepresentation checkValidObjectReference: literal)) ifFalse:
			[^1].
		((objectRepresentation couldBeObject: literal)
		 and: [coInterpreter isReallyYoungObject: literal]) ifTrue:
			[(self asserta: (self cCoerceSimple: cogMethod to: #'CogMethod *') cmRefersToYoung) ifFalse:
				[^2]]].
	(self isSendAnnotation: annotation) ifTrue:
		[(self asserta: (self cCoerceSimple: cogMethod to: #'CogMethod *') cmType = CMMethod) ifFalse:
			[^3].
		 cacheTag := backEnd inlineCacheTagAt: mcpc asInteger.
		 (self asserta: (objectRepresentation checkValidInlineCacheTag: cacheTag)) ifFalse:
			[^4].
		((objectRepresentation couldBeObject: cacheTag)
		 and: [coInterpreter isReallyYoungObject: cacheTag]) ifTrue:
			[(self asserta: (self cCoerceSimple: cogMethod to: #'CogMethod *') cmRefersToYoung) ifFalse:
				[^5]].
		entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		entryPoint > methodZoneBase ifTrue:
			["It's a linked send; find which kind."
			 self
				offsetAndSendTableFor: entryPoint
				annotation: annotation
				into: [:off :table| offset := off].
			 targetMethod := self cCoerceSimple: entryPoint - offset to: #'CogMethod *'.
			 (self asserta: (targetMethod cmType = CMMethod
						   or: [targetMethod cmType = CMClosedPIC
						   or: [targetMethod cmType = CMOpenPIC]])) ifFalse:
				[^6]]].
	^0 "keep scanning"