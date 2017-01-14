type inference
typeForConditional: sendNode in: aTMethod
	"Answer the return type for a conditional, ifTrue:ifFalse: et al"
	| firstType secondType |
	firstType := self typeFor: sendNode args first statements last in: aTMethod.
	sendNode selector numArgs = 1 ifTrue:
		[^firstType].
	secondType := self typeFor: sendNode args second statements last in: aTMethod.
	((firstType notNil and: [(self isIntegralCType: firstType) or: [self isFloatingPointCType: firstType]])
	 and: [secondType notNil and: [(self isIntegralCType: secondType) or: [self isFloatingPointCType: secondType]]]) ifTrue:
		[^self promoteArithmeticTypes: firstType and: secondType].
	^firstType ifNil: [secondType]