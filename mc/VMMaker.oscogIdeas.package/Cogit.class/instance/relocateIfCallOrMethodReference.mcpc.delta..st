compaction
relocateIfCallOrMethodReference: annotation mcpc: mcpc delta: refDelta
	<var: #mcpc type: #'char *'>
	| callDelta entryPoint targetMethod unlinkedRoutine |
	<var: #targetMethod type: #'CogMethod *'>
	<var: #nsSendCache type: #'NSSendCache *'>

	callDelta := backEnd zoneCallsAreRelative ifTrue: [refDelta] ifFalse: [0].
	
	NewspeakVM ifTrue:
		[| nsSendCache |
		 annotation = IsNSSendCall ifTrue:
			["Retrieve the send cache before relocating the stub call. Fetching the send
			  cache asserts the stub call points below all the cogged methods, but
			  until this method is actually moved, the adjusted stub call may appear to
			  point to somewhere in the method zone."
			nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.

			"Fix call to trampoline. This method is moving [delta] bytes, and calls are
			 relative, so adjust the call by -[delta] bytes"
			backEnd relocateCallBeforeReturnPC: mcpc asInteger by: callDelta negated.

			nsSendCache target ~= 0 ifTrue: "Send is linked"
				[entryPoint := nsSendCache target.
				targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
				targetMethod cmType = CMMethod
					ifTrue: "send target not freed; just relocate. The cache has an absolute
							target, so only adjust by the target method's displacement."
						[nsSendCache target: entryPoint + targetMethod objectHeader]
					ifFalse: "send target was freed, unlink"
						[self voidNSSendCache: nsSendCache]].
			^0]].

	(self isPureSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		entryPoint <= methodZoneBase ifTrue: "send is not linked; just relocate"
			[backEnd relocateCallBeforeReturnPC: mcpc asInteger by: callDelta negated.
			 ^0].
		"It's a linked send; find which kind."
		self
			offsetAndSendTableFor: entryPoint
			annotation: annotation
			into: [:offset :sendTable|
				 targetMethod := self cCoerceSimple: entryPoint - offset to: #'CogMethod *'.
				 targetMethod cmType ~= CMFree ifTrue: "send target not freed; just relocate."
					[backEnd
						relocateCallBeforeReturnPC: mcpc asInteger
						by: (callDelta - targetMethod objectHeader) negated.
					 SistaVM ifTrue: "See comment in planCompaction"
						[methodZone restorePICUsageCount: targetMethod].
					 ^0].
				 "Target was freed; map back to an unlinked send; but include this method's reocation"
				 unlinkedRoutine := sendTable at: (targetMethod cmNumArgs min: NumSendTrampolines - 1).
				 unlinkedRoutine := unlinkedRoutine - callDelta.
				 backEnd
					rewriteInlineCacheAt: mcpc asInteger
					tag: (self inlineCacheValueForSelector: targetMethod selector in: enumeratingCogMethod at: mcpc)
					target: unlinkedRoutine.
				 ^0]].

	annotation = IsRelativeCall ifTrue:
		[backEnd relocateCallBeforeReturnPC: mcpc asInteger by: callDelta negated.
		 ^0].

	annotation = IsAbsPCReference ifTrue:
		[backEnd relocateMethodReferenceBeforeAddress: mcpc asInteger by: refDelta].

	^0 "keep scanning"