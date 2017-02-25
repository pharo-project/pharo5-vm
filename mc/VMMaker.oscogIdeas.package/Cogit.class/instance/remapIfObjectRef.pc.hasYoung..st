garbage collection
remapIfObjectRef: annotation pc: mcpc hasYoung: hasYoungPtr
	<var: #mcpc type: #'char *'>
	<var: #targetMethod type: #'CogMethod *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	annotation = IsObjectReference ifTrue:
		[| literal mappedLiteral |
		 literal := literalsManager fetchLiteralAtAnnotatedAddress: mcpc asUnsignedInteger using: backEnd.
		 (objectRepresentation couldBeObject: literal) ifTrue:
			[mappedLiteral := objectRepresentation remapObject: literal.
			 literal ~= mappedLiteral ifTrue:
				[literalsManager storeLiteral: mappedLiteral atAnnotatedAddress: mcpc asUnsignedInteger using: backEnd.
				 codeModified := true].
			 (hasYoungPtr ~= 0
			  and: [objectMemory isYoung: mappedLiteral]) ifTrue:
				[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]]].

	NewspeakVM ifTrue: [annotation = IsNSSendCall ifTrue:
		[| nsSendCache oop mappedOop |
		nsSendCache := self nsSendCacheFromReturnAddress: mcpc.
		oop := nsSendCache selector.	
		mappedOop := objectRepresentation remapObject: oop.
		oop ~= mappedOop ifTrue:
			[nsSendCache selector: mappedOop.
			(hasYoungPtr ~= 0 and: [objectMemory isYoung: mappedOop]) ifTrue:
				[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]].
		oop := nsSendCache enclosingObject.	
		oop ~= 0 ifTrue: [
			mappedOop := objectRepresentation remapObject: oop.
			oop ~= mappedOop ifTrue:
				[nsSendCache enclosingObject: mappedOop.
				(hasYoungPtr ~= 0 and: [objectMemory isYoung: mappedOop]) ifTrue:
					[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]]].
		^0 "keep scanning"]].

	(self isPureSendAnnotation: annotation) ifTrue:
		[self entryCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:entryPoint :cacheTag :tagCouldBeObj | | mappedCacheTag |
			 (tagCouldBeObj
			  and: [objectRepresentation couldBeObject: cacheTag]) ifTrue:
				[mappedCacheTag := objectRepresentation remapObject: cacheTag.
				 cacheTag ~= mappedCacheTag ifTrue:
					[backEnd rewriteInlineCacheTag: mappedCacheTag at: mcpc asUnsignedInteger.
					 codeModified := true].
				 (hasYoungPtr ~= 0
				  and: [objectMemory isYoung: mappedCacheTag]) ifTrue:
					[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]].
			hasYoungPtr ~= 0 ifTrue:
				["Since the unlinking routines may rewrite the cacheTag to the send's selector, and
				  since they don't have the cogMethod to hand and can't add it to youngReferrers,
				  the method must remain in youngReferrers if the targetMethod's selector is young."
				 entryPoint > methodZoneBase ifTrue: "It's a linked send."
					[self targetMethodAndSendTableFor: entryPoint annotation: annotation into:
						[:targetMethod :ignored|
						 (objectMemory isYoung: targetMethod selector) ifTrue:
							[(self cCoerceSimple: hasYoungPtr to: #'sqInt *') at: 0 put: true]]]]]].
	^0 "keep scanning"