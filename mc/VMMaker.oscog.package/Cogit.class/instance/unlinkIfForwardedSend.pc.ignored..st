in-line cacheing
unlinkIfForwardedSend: annotation pc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| entryPoint |

	self cppIf: NewspeakVM ifTrue:
		[| nsSendCache |
		 annotation = IsNSSendCall ifTrue:
			[nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
			nsSendCache classTag ~= 0 ifTrue:
				[(objectMemory isForwardedClassIndex: nsSendCache classTag) ifTrue: [
					nsSendCache classTag: 0; enclosingObject: 0; target: 0]].
			"Should we check if the enclosing object's class is forwarded as well?"
			^0 "keep scanning"]].

	annotation = IsSendCall ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send, but maybe a super send or linked to an OpenPIC, in which case the cache tag will be a selector...."
				[(objectMemory isForwardedClassIndex: (backEnd inlineCacheTagAt: mcpc asInteger)) ifTrue:
					[self targetMethodAndSendTableFor: entryPoint into:
						[:targetMethod :sendTable|
						 self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]]].

	^0 "keep scanning"