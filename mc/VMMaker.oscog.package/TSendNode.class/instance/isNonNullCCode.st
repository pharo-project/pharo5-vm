testing
isNonNullCCode
	^(#(cCode: cCode:inSmalltalk:) includes: selector)
	   and: [arguments first isConstant
	   and: [arguments first value isString
	   and: [arguments first value notEmpty]]]