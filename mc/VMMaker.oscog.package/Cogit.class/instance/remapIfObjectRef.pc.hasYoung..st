garbage collection
remapIfObjectRef: annotation pc: mcpc hasYoung: hasYoungPtr
	<var: #mcpc type: #'char *'>
	<var: #targetMethod type: #'CogMethod *'>
	annotation = IsObjectReference ifTrue:
		[| literal mappedLiteral |
		 literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 (objectRepresentation couldBeObject: literal) ifTrue:
			[mappedLiteral := objectRepresentation remapObject: literal.
			 literal ~= mappedLiteral ifTrue:
				[backEnd storeLiteral: mappedLiteral beforeFollowingAddress: mcpc asInteger.
				 codeModified := true].
			 (hasYoungPtr ~= 0
			  and: [objectMemory isYoung: mappedLiteral]) ifTrue:
				[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]]].
	(self isSendAnnotation: annotation) ifTrue:
		[self offsetCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:entryPoint :cacheTag :tagCouldBeObj | | mappedCacheTag |
			 (tagCouldBeObj
			  and: [objectRepresentation couldBeObject: cacheTag]) ifTrue:
				[mappedCacheTag := objectRepresentation remapObject: cacheTag.
				 cacheTag ~= mappedCacheTag ifTrue:
					[backEnd rewriteInlineCacheTag: mappedCacheTag at: mcpc asInteger.
					 codeModified := true].
				 (hasYoungPtr ~= 0
				  and: [objectMemory isYoung: mappedCacheTag]) ifTrue:
					[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]].
			 (self cppIf: NewspeakVM
					ifTrue: [entryPoint = ceImplicitReceiverTrampoline]
					ifFalse: [false])
				ifTrue:
					[| pc oop mappedOop |
					 pc := mcpc asInteger + backEnd jumpShortByteSize.
					 (oop := backEnd unalignedLongAt: pc) ~= 0 ifTrue:
						[mappedOop := objectRepresentation remapOop: oop.
						 mappedOop ~= oop ifTrue:
							[backEnd unalignedLongAt: pc put: mappedOop].
						 (hasYoungPtr ~= 0
						  and: [objectMemory isYoung: mappedOop]) ifTrue:
							[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true].
						 pc := mcpc asInteger + backEnd jumpShortByteSize + BytesPerOop.
						 (oop := backEnd unalignedLongAt: pc) ~= 0 ifTrue:
							[mappedOop := objectRepresentation remapOop: oop.
							 mappedOop ~= oop ifTrue:
								[backEnd unalignedLongAt: pc put: mappedOop].
						 (hasYoungPtr ~= 0
						  and: [objectMemory isYoung: mappedOop]) ifTrue:
							[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]]]]
				ifFalse:
					[hasYoungPtr ~= 0 ifTrue:
						["Since the unlinking routines may rewrite the cacheTag to the send's selector, and
						  since they don't have the cogMethod to hand and can't add it to youngReferrers,
						  the method must remain in youngReferrers if the targetMethod's selector is young."
						 entryPoint > methodZoneBase ifTrue: "It's a linked send."
							[self targetMethodAndSendTableFor: entryPoint into:
								[:targetMethod :ignored|
								 (objectMemory isYoung: targetMethod selector) ifTrue:
									[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]]]]]]].
	^0 "keep scanning"