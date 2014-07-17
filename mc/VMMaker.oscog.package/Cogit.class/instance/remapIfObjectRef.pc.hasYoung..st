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
				ifTrue: "Examine an implicit receiver cache."
					[| cacheAddress oop mappedOop |
					 self assert: NumOopsPerIRC = 2.
					 cacheAddress := self implicitReceiverCacheAddressAt: mcpc.
					 (oop := backEnd unalignedLongAt: cacheAddress) ~= 0 ifTrue:
						["First look at the classTag entry.  This is an inline cache tag and so might not be an object."
						 (objectRepresentation inlineCacheTagsMayBeObjects
						  and: [objectRepresentation couldBeObject: oop]) ifTrue:
							[mappedOop := objectRepresentation remapOop: oop.
							 mappedOop ~= oop ifTrue:
								[backEnd unalignedLongAt: cacheAddress put: mappedOop].
							 (hasYoungPtr ~= 0
							  and: [objectMemory isYoung: mappedOop]) ifTrue:
								[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]].
						 "Second look at the mixin entry. this must be 0 or an object."
						 (oop := backEnd unalignedLongAt: cacheAddress + BytesPerOop) ~= 0 ifTrue:
							[mappedOop := objectRepresentation remapOop: oop.
							 mappedOop ~= oop ifTrue:
								[backEnd unalignedLongAt: cacheAddress + BytesPerOop put: mappedOop].
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