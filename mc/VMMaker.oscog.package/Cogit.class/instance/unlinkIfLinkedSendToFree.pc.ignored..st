in-line cacheing
unlinkIfLinkedSendToFree: annotation pc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	<var: #nsTargetMethod type: #'CogMethod *'>
	| entryPoint |

	self cppIf: NewspeakVM ifTrue:
		[| nsSendCache nsTargetMethod |
		 annotation = IsNSSendCall ifTrue:
			[nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
			(entryPoint := nsSendCache target) ~= 0 ifTrue: "It's a linked send."
				[nsTargetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
				nsTargetMethod cmType = CMFree ifTrue:
					[nsSendCache classTag: 0.
					nsSendCache enclosingObject: 0.
					nsSendCache target: 0]].
			^0 "keep scanning"]].

	annotation = IsSendCall ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase ifTrue: "It's a linked send."
			[self targetMethodAndSendTableFor: entryPoint into:
				[:targetMethod :sendTable| 
				 targetMethod cmType = CMFree ifTrue:
					[self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]]].

	^0 "keep scanning"