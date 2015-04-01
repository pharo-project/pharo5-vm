garbage collection
markLiterals: annotation pc: mcpc method: cogMethod
	"Mark and trace literals.
	 Additionally in Newspeak, void push implicits that have unmarked classes."
	<var: #mcpc type: #'char *'>
	<var: #nsSendCache type: #'NSSendCache *'>
	| literal nsSendCache |
	annotation = IsObjectReference ifTrue:
		[literal := backEnd literalBeforeFollowingAddress: mcpc asUnsignedInteger.
		 (objectRepresentation
				markAndTraceLiteral: literal
				in: (self cCoerceSimple: cogMethod to: #'CogMethod *')
				atpc: mcpc asUnsignedInteger) ifTrue:
			[codeModified := true]].

	self cppIf: NewspeakVM ifTrue: [annotation = IsNSSendCall ifTrue:
		[ | sel eo |
		nsSendCache := self nsSendCacheFromReturnAddress: mcpc asInteger.
		sel := nsSendCache selector.
			(objectMemory isForwarded: sel)
				ifFalse: [objectMemory markAndTrace: sel]
				ifTrue: [sel := objectMemory followForwarded: literal.
						nsSendCache selector: sel.
						self markAndTraceUpdatedLiteral: sel in: (self cCoerceSimple: cogMethod to: #'CogMethod *')].
		eo := nsSendCache enclosingObject.
		eo ~= 0 ifTrue: [
			(objectMemory isForwarded: eo)
				ifFalse: [objectMemory markAndTrace: eo]
				ifTrue: [eo := objectMemory followForwarded: literal.
						nsSendCache enclosingObject: eo.
						self markAndTraceUpdatedLiteral: eo in: (self cCoerceSimple: cogMethod to: #'CogMethod *')]]]].

	annotation = IsSendCall ifTrue:
		[self offsetCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:entryPoint :cacheTag :tagCouldBeObj |
			 tagCouldBeObj ifTrue:
				[(objectRepresentation
						markAndTraceCacheTagLiteral: cacheTag
						in: (self cCoerceSimple: cogMethod to: #'CogMethod *')
						atpc: mcpc asUnsignedInteger) ifTrue:
					["cacheTag is selector" codeModified := true]]]].

	^0 "keep scanning"