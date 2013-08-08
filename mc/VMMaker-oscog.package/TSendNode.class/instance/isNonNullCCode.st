testing
isNonNullCCode
	^(#(cCode: cCode:inSmalltalk:) includes: selector)
	   and: [arguments first isConstant
	   and: [arguments first value notEmpty]]