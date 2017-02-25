garbage collection
markYoungObjects: annotation pc: mcpc method: cogMethod
	"Mark and trace young literals."
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| literal |
	annotation = IsObjectReference ifTrue:
		[literal := literalsManager fetchLiteralAtAnnotatedAddress: mcpc asUnsignedInteger using: backEnd.
		 objectRepresentation markAndTraceLiteralIfYoung: literal].

	NewspeakVM ifTrue: [annotation = IsNSSendCall ifTrue:
		[| nsSendCache |
		 nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
		 objectRepresentation markAndTraceLiteralIfYoung: nsSendCache selector.
		 nsSendCache enclosingObject ~= 0 ifTrue:
			[objectRepresentation markAndTraceLiteralIfYoung: nsSendCache enclosingObject]]].

	(self isPureSendAnnotation: annotation) ifTrue:
		[self entryCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:entryPoint :cacheTag :tagCouldBeObj |
			 tagCouldBeObj ifTrue:
				[objectRepresentation markAndTraceLiteralIfYoung: cacheTag]]].

	^0 "keep scanning"