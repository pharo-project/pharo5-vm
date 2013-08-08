garbage collection
remapNSIfObjectRef: annotation pc: mcpc hasYoung: hasYoungPtr
	<option: #NewspeakVM>
	<var: #mcpc type: #'char *'>
	<var: #targetMethod type: #'CogMethod *'>
	annotation = IsObjectReference ifTrue:
		[| literal mappedLiteral |
		 literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 (objectRepresentation couldBeObject: literal) ifTrue:
			[mappedLiteral := objectMemory remap: literal.
			 literal ~= mappedLiteral ifTrue:
				[backEnd storeLiteral: mappedLiteral beforeFollowingAddress: mcpc asInteger.
				 codeModified := true].
			 (hasYoungPtr ~= 0
			  and: [objectMemory isYoung: mappedLiteral]) ifTrue:
				[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]]].
	(self isSendAnnotation: annotation) ifTrue:
		[| cacheTag mappedCacheTag entryPoint |
		 cacheTag := backEnd inlineCacheTagAt: mcpc asInteger.
		 (objectRepresentation couldBeObject: cacheTag) ifTrue:
			[mappedCacheTag := objectMemory remap: cacheTag.
			 cacheTag ~= mappedCacheTag ifTrue:
				[backEnd rewriteInlineCacheTag: mappedCacheTag at: mcpc asInteger.
				 codeModified := true].
			 (hasYoungPtr ~= 0
			  and: [objectMemory isYoung: mappedCacheTag]) ifTrue:
				[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]].
		 entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint = ceImplicitReceiverTrampoline
			ifTrue:
				[| pc oop mappedOop |
				 pc := mcpc asInteger + backEnd jumpShortByteSize.
				 (oop := backEnd unalignedLongAt: pc) ~= 0 ifTrue:
					[mappedOop := objectMemory remap: oop.
					 mappedOop ~= oop ifTrue:
						[backEnd unalignedLongAt: pc put: mappedOop].
					 (hasYoungPtr ~= 0
					  and: [objectMemory isYoung: mappedOop]) ifTrue:
						[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true].
					 pc := mcpc asInteger + backEnd jumpShortByteSize + BytesPerOop.
					 (oop := backEnd unalignedLongAt: pc) ~= 0 ifTrue:
						[mappedOop := objectMemory remap: oop.
						 mappedOop ~= oop ifTrue:
							[backEnd unalignedLongAt: pc put: mappedOop].
					 (hasYoungPtr ~= 0
					  and: [objectMemory isYoung: mappedOop]) ifTrue:
						[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]]]]
			ifFalse:
				[hasYoungPtr ~= 0 ifTrue:
					[| offset targetMethod |
					 "Since the unlinking routines may rewrite the cacheTag to the send's selector, and
					  since they don't have the cogMethod to hand and can't add it to youngReferrers,
					  the method must remain in youngReferrers if the targetMethod's selector is young."
					 entryPoint > methodZoneBase ifTrue: "It's a linked send."
						[offset := (entryPoint bitAnd: entryPointMask) = checkedEntryAlignment
									ifTrue: [cmEntryOffset]
									ifFalse: [cmNoCheckEntryOffset].
						targetMethod := self cCoerceSimple: entryPoint - offset to: #'CogMethod *'.
						(objectMemory isYoung: targetMethod selector) ifTrue:
							[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]]]]].
	^0 "keep scanning"