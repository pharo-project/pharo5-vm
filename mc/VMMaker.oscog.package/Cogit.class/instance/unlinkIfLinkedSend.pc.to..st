in-line cacheing
unlinkIfLinkedSend: annotation pc: mcpc to: theCogMethod
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| entryPoint nsSendCache |

	self cppIf: NewspeakVM ifTrue: [annotation = IsNSSendCall ifTrue:
		[nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
		(entryPoint := nsSendCache target) ~= 0 ifTrue:
			[ | targetMethod |
			targetMethod := entryPoint - cmNoCheckEntryOffset.
			targetMethod = theCogMethod ifTrue:
				[nsSendCache classTag: 0.
				nsSendCache enclosingObject: 0.
				nsSendCache target: 0]].
		^0 "keep scanning"]].

	annotation = IsSendCall ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send."
				[self targetMethodAndSendTableFor: entryPoint into:
					[:targetMethod :sendTable| 
					 targetMethod asInteger = theCogMethod ifTrue:
						[self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]]].

	^0 "keep scanning"