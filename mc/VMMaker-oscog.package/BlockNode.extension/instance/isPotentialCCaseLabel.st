*VMMaker-C translation
isPotentialCCaseLabel
	| stmt |
	^statements size = 1
	  and: [(stmt := statements first) isVariableNode
		or: [(stmt isLiteral
				and: [stmt isConstantNumber or: [stmt literalValue isSymbol]])
		or: [stmt isMessageNode
			and: [stmt selector key = #asSymbol
			and: [stmt receiver isLiteral
			and: [stmt receiver literalValue isSymbol]]]]]]