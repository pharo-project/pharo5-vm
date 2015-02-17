inlining
isActualType: actualTypeOrNil compatibleWithFormalType: formalTypeOrNil 
	| actualType formalType |
	actualType := actualTypeOrNil ifNil: [#sqInt].
	formalType := formalTypeOrNil ifNil: [#sqInt].
	((self isIntegralCType: actualType)
	 and: [self isIntegralCType: formalType]) ifFalse:
		[^actualType = formalType].
	"For now, insist that the signedness agrees."
	^(actualType first = $u) = (formalType first = $u)
	 or: [actualTypeOrNil isNil or: [formalTypeOrNil isNil]]