in-line cacheing
unlinkIfLinkedSend: annotation pc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| entryPoint nsSendCache |

	self cppIf: NewspeakVM ifTrue: [annotation = IsNSSendCall ifTrue:
		[nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
		nsSendCache classTag ~= 0 ifTrue: "Send is linked"
			[nsSendCache classTag: 0; enclosingObject: 0; target: 0].
		^0 "keep scanning"]].

	annotation = IsSendCall ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send."
				[self targetMethodAndSendTableFor: entryPoint into:
					[:targetMethod :sendTable| 
					 self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]].

	^0 "keep scanning"