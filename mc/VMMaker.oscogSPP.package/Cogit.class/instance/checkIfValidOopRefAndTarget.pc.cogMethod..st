garbage collection
checkIfValidOopRefAndTarget: annotation pc: mcpc cogMethod: cogMethod
	"Check for a valid object reference, if any, at a map entry.  Answer a code unique to each error for debugging."
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| literal entryPoint |
	annotation = IsObjectReference ifTrue:
		[literal := literalsManager fetchLiteralAtAnnotatedAddress: mcpc asUnsignedInteger using: backEnd.
		 (self asserta: (objectRepresentation checkValidOopReference: literal)) ifFalse:
			[^1].
		((objectRepresentation couldBeObject: literal)
		 and: [objectMemory isReallyYoungObject: literal]) ifTrue:
			[(self asserta: (self cCoerceSimple: cogMethod to: #'CogMethod *') cmRefersToYoung) ifFalse:
				[^2]]].

	NewspeakVM ifTrue:
		[annotation = IsNSSendCall ifTrue:
			[| nsSendCache classTag enclosingObject nsTargetMethod |
			nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
			(self asserta: (objectRepresentation checkValidOopReference: nsSendCache selector)) ifFalse:
				[^9].
			classTag := nsSendCache classTag.
			(self asserta: (classTag = 0 or: [objectRepresentation validInlineCacheTag: classTag])) ifFalse:
				[^10].
			enclosingObject := nsSendCache enclosingObject.
			(self asserta: (enclosingObject = 0 or: [objectRepresentation checkValidOopReference: enclosingObject])) ifFalse:
				[^11].
			entryPoint := nsSendCache target.
			entryPoint ~= 0 ifTrue: [
				nsTargetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
				(self asserta: (nsTargetMethod cmType = CMMethod)) ifFalse:
					[^12]]]].

	(self isPureSendAnnotation: annotation) ifTrue:
		[(self asserta: (self cCoerceSimple: cogMethod to: #'CogMethod *') cmType = CMMethod) ifFalse:
			[^3].
		 self offsetCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:offset :cacheTag :tagCouldBeObject|
			tagCouldBeObject
				ifTrue:
					[(objectRepresentation couldBeObject: cacheTag)
						ifTrue:
							[(self asserta: (objectRepresentation checkValidOopReference: cacheTag)) ifFalse:
								[^4]]
						ifFalse:
							[(self asserta: (objectRepresentation validInlineCacheTag: cacheTag)) ifFalse:
								[^5]].
					((objectRepresentation couldBeObject: cacheTag)
					 and: [objectMemory isReallyYoungObject: cacheTag]) ifTrue:
						[(self asserta: (self cCoerceSimple: cogMethod to: #'CogMethod *') cmRefersToYoung) ifFalse:
							[^6]]]
				ifFalse:
					[(self asserta: (objectRepresentation validInlineCacheTag: cacheTag)) ifFalse:
						[^7]]].
		entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		entryPoint > methodZoneBase ifTrue:
			["It's a linked send; find which kind."
			 self targetMethodAndSendTableFor: entryPoint annotation: annotation into:
					[:targetMethod :sendTable|
					 (self asserta: (targetMethod cmType = CMMethod
								   or: [targetMethod cmType = CMClosedPIC
								   or: [targetMethod cmType = CMOpenPIC]])) ifFalse:
						[^8]]]].
	^0 "keep scanning"