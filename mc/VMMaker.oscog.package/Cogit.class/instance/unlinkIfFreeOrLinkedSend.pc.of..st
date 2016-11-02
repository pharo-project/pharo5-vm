in-line cacheing
unlinkIfFreeOrLinkedSend: annotation pc: mcpc of: theSelector
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| entryPoint |

	NewspeakVM ifTrue:
		[| nsSendCache |
		 annotation = IsNSSendCall ifTrue:
			[nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
			 (entryPoint := nsSendCache target) ~= 0 ifTrue:
				[ | targetMethod |
				targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
				(targetMethod cmType = CMFree or: [nsSendCache selector = theSelector]) ifTrue:
					[self voidNSSendCache: nsSendCache]].
			^0 "keep scanning"]].

	(self isPureSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send."
				[self targetMethodAndSendTableFor: entryPoint annotation: annotation into:
					[:targetMethod :sendTable| 
					 (targetMethod cmType = CMFree
					  or: [targetMethod selector = theSelector]) ifTrue:
						[self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]]].

	^0 "keep scanning"