inlining
isActualType: actualTypeOrNil compatibleWithFormalType: formalTypeOrNil 
	| actualType formalType |
	actualType := actualTypeOrNil ifNil: [#sqInt].
	formalType := formalTypeOrNil ifNil: [#sqInt].
	((self isIntegralCType: actualType)
	 and: [self isIntegralCType: formalType]) ifFalse:
		[^actualType = formalType
		 or: [formalType = #double and: [actualType = #float]]].
	"For now, insist that the signedness agrees.  If the actual's type is unknown allow inlining.
	 A formal defaults to #sqInt. Allowing inlining an unsigned type within a sqInt formal is wrong;
	 snd for testing, it breaks e.g. the BitBltPlugin."
	^(actualType first = $u) = (formalType first = $u)
	  or: [actualTypeOrNil isNil] 