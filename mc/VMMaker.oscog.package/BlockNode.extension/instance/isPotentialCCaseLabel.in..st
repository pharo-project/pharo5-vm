*VMMaker-C translation
isPotentialCCaseLabel: stmt in: aTMethod
	(stmt isVariableNode
	 or: [stmt isLiteralNode
		and: [stmt isConstantNumber or: [stmt literalValue isSymbol]]]) ifTrue:
		[^true].
	stmt isMessageNode ifTrue:
		[| selector method |
		 selector := stmt selector key.
		 (#(* + -) includes: selector) ifTrue:
			[^(self isPotentialCCaseLabel: stmt receiver in: aTMethod)
			   and: [self isPotentialCCaseLabel: stmt arguments first in: aTMethod]].

		 (selector = #asSymbol
		  and: [stmt receiver isLiteralNode
		  and: [stmt receiver literalValue isSymbol]]) ifTrue:
			[^true].

		 (stmt arguments isEmpty
		  and: [method := (aTMethod definingClass whichClassIncludesSelector: selector) >> selector.
			   (method isQuick
				or: [(method literalAt: 1) isInteger
					and: [method numLiterals = 3]])
		   and: [(aTMethod definingClass basicNew perform: selector) isInteger]]) ifTrue:
				[^true]].
	^false