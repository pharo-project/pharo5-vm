garbage collection
markLiteralsAndUnlinkIfUnmarkedSend: annotation pc: mcpc method: cogMethod
	"Mark and trace literals.  Unlink sends that have unmarked cache tags or targets."
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| literal |
	annotation = IsObjectReference ifTrue:
		[literal := literalsManager fetchLiteralAtAnnotatedAddress: mcpc asUnsignedInteger using: backEnd.
		 (objectRepresentation
				markAndTraceLiteral: literal
				in: (self cCoerceSimple: cogMethod to: #'CogMethod *')
				atpc: mcpc asUnsignedInteger) ifTrue:
			[codeModified := true]].

	NewspeakVM ifTrue:
		[annotation = IsNSSendCall ifTrue:
			[| nsSendCache entryPoint targetMethod sel eo |
			nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
			entryPoint := nsSendCache target.
			entryPoint ~= 0 ifTrue: "Send is linked"
				[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
				 (self markAndTraceOrFreeCogMethod: targetMethod
					firstVisit: targetMethod asUnsignedInteger > mcpc asUnsignedInteger) ifTrue:	
						[self voidNSSendCache: nsSendCache]].
			sel := nsSendCache selector.
			(objectMemory isForwarded: sel)
				ifFalse: [objectMemory markAndTrace: sel]
				ifTrue: [sel := objectMemory followForwarded: literal.
						nsSendCache selector: sel.
						self markAndTraceUpdatedLiteral: sel in: (self cCoerceSimple: cogMethod to: #'CogMethod *')].
			eo := nsSendCache enclosingObject.
			eo ~= 0 ifTrue:
				[(objectMemory isForwarded: eo)
					ifFalse: [objectMemory markAndTrace: eo]
					ifTrue: [eo := objectMemory followForwarded: literal.
							nsSendCache enclosingObject: eo.
							self markAndTraceUpdatedLiteral: eo in: (self cCoerceSimple: cogMethod to: #'CogMethod *')]]]].

	(self isPureSendAnnotation: annotation) ifTrue:
		[self offsetCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:entryPoint :cacheTag :tagCouldBeObj | | cacheTagMarked |
			 cacheTagMarked := tagCouldBeObj and: [objectRepresentation cacheTagIsMarked: cacheTag].
			 entryPoint > methodZoneBase
				ifTrue: "It's a linked send."
					[self targetMethodAndSendTableFor: entryPoint annotation: annotation into:
						[:targetMethod :sendTable| 
						 (cacheTagMarked not
						  or: [self markAndTraceOrFreeCogMethod: targetMethod
								firstVisit: targetMethod asUnsignedInteger > mcpc asUnsignedInteger]) ifTrue:
							["Either the cacheTag is unmarked (e.g. new class) or the target
							  has been freed (because it is unmarked), so unlink the send."
							 self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable.
							 objectRepresentation
								markAndTraceLiteral: targetMethod selector
								in: targetMethod
								at: (self addressOf: targetMethod selector put: [:val| targetMethod selector: val])]]]
				ifFalse:  "cacheTag is selector"
					[(objectRepresentation
							markAndTraceCacheTagLiteral: cacheTag
							in: (self cCoerceSimple: cogMethod to: #'CogMethod *')
							atpc: mcpc asUnsignedInteger) ifTrue:
						[codeModified := true]]]].

	^0 "keep scanning"