in-line cacheing
unlinkIfLinkedSend: annotation pc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| entryPoint |

	self cppIf: NewspeakVM ifTrue:
		[| nsSendCache |
		 annotation = IsNSSendCall ifTrue:
			[nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
			nsSendCache classTag ~= objectRepresentation illegalClassTag ifTrue: "Send is linked"
				[nsSendCache classTag: objectRepresentation illegalClassTag; enclosingObject: 0; target: 0].
			^0 "keep scanning"]].

	(self isPureSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send."
				[self targetMethodAndSendTableFor: entryPoint annotation: annotation into:
					[:targetMethod :sendTable| 
					 self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]].

	^0 "keep scanning"