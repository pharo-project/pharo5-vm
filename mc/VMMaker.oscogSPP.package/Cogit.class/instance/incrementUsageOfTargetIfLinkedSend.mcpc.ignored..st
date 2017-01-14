compaction
incrementUsageOfTargetIfLinkedSend: annotation mcpc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| entryPoint |

	NewspeakVM ifTrue:
		[annotation = IsNSSendCall ifTrue:
			[| nsSendCache |
			 nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
			 nsSendCache classTag ~= objectRepresentation illegalClassTag ifTrue: "send is linked"
				[ | targetMethod |
				entryPoint := nsSendCache target.
				targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
				self assert: (self isPCWithinMethodZone: targetMethod).
				targetMethod cmUsageCount < (CMMaxUsageCount // 2) ifTrue:
					[targetMethod cmUsageCount: targetMethod cmUsageCount + 1]]]].

	(self isPureSendAnnotation: annotation) ifTrue:
		[self assert: annotation ~= IsNSSendCall.
		 entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase ifTrue: "It's a linked send."
			[self targetMethodAndSendTableFor: entryPoint annotation: annotation into:
				[:targetMethod :sendTable|
				 targetMethod cmUsageCount < (CMMaxUsageCount // 2) ifTrue:
					[targetMethod cmUsageCount: targetMethod cmUsageCount + 1]]]].

	^0 "keep scanning"