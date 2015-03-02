inlining
variableOfType: variableType acceptsValue: exprNode ofType: expressionType
	"Simple type checking for assignment/return values"

	^variableType isNil "means as yet untyped, hence can adapt"
	  or: [expressionType isNil "means we don't know.  Potentially dangerous to say yes, but Slang is traditionally lax :("
	  or: [variableType = expressionType
	  or: [variableType notNil
		 and: [(variableType includes: $*)
				ifTrue:
					[(exprNode isVariable and: [exprNode name = 'nil'])
					  or: [expressionType last = $*
						   and: [(self isVoidPointer: variableType)
								or: [self isVoidPointer: expressionType]]]]
				ifFalse: "Require a cast if assigning integral with floating-point but not the other way around"
					[((self isIntegralCType: variableType)
					   and: [(self isIntegralCType: expressionType)
					   and: [(self sizeOfIntegralCType: variableType) >= (self sizeOfIntegralCType: expressionType)]])
					or: [(self isFloatingPointCType: variableType)
						and: [(self isFloatingPointCType: expressionType)
							or: [self isIntegralCType: expressionType]]]]]]]]