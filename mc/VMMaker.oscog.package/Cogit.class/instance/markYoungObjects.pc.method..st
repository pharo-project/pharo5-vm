garbage collection
markYoungObjects: annotation pc: mcpc method: cogMethod
	"Mark and trace young literals."
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| literal |
	annotation = IsObjectReference ifTrue:
		[literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 objectRepresentation markAndTraceLiteralIfYoung: literal].

	self cppIf: NewspeakVM ifTrue: [annotation = IsNSSendCall ifTrue:
		[| nsSendCache |
		 nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
		 objectRepresentation markAndTraceLiteralIfYoung: nsSendCache selector.
		 nsSendCache enclosingObject ~= 0 ifTrue:
			[objectRepresentation markAndTraceLiteralIfYoung: nsSendCache enclosingObject]]].

	annotation = IsSendCall ifTrue:
		[self offsetCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:entryPoint :cacheTag :tagCouldBeObj |
			 tagCouldBeObj ifTrue:
				[objectRepresentation markAndTraceLiteralIfYoung: cacheTag]]].

	^0 "keep scanning"