in-line cacheing
unlinkIfInvalidClassSend: annotation pc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| entryPoint |

	NewspeakVM ifTrue:
		[| nsSendCache |
		 annotation = IsNSSendCall ifTrue:
			[nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
			 (nsSendCache classTag ~= objectRepresentation illegalClassTag
			  and: [objectMemory isForwardedClassIndex: nsSendCache classTag]) ifTrue:
				[self voidNSSendCache: nsSendCache]].
			"Should we check if the enclosing object's class is forwarded as well?"
			^0 "keep scanning"].

	(self isPureSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase ifTrue: "It's a linked send, but maybe a super send or linked to an OpenPIC, in which case the cache tag will be a selector...."
			[self targetMethodAndSendTableFor: entryPoint annotation: annotation into:
				[:targetMethod :sendTable|
				 ((self annotationIsForUncheckedEntryPoint: annotation)
				  or: [targetMethod cmType = CMOpenPIC]) ifFalse:
					[(objectMemory isValidClassTag: (backEnd inlineCacheTagAt: mcpc asInteger)) ifFalse:
						[self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]]]].

	^0 "keep scanning"