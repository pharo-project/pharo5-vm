inlining
node: exprNode typeCompatibleWith: argName inliningInto: targetMethod in: aTMethod
	"Answer either exprNode or, if required, a cast of exprNode to the type of argName.
	 The cast is required if
		- argName is typed and exprNode is untyped
		- argName is untyped and exprNode is an arithmetic type of size > #sqInt
		- both argName and exprNode are typed but they are incompatible"
	| formalType actualType |
	formalType := targetMethod typeFor: argName in: self.
	actualType := self typeFor: exprNode in: aTMethod.
	^((exprNode isSend or: [exprNode isVariable])
	   and: [(formalType notNil and: [actualType isNil])
			or: [(formalType isNil and: [actualType notNil and: [(self isIntegralCType: actualType) and: [(self sizeOfIntegralCType: actualType) > (self sizeOfIntegralCType: #sqInt)]]])
			or: [(self variableOfType: formalType acceptsValue: exprNode ofType: actualType) not]]])
		ifTrue: [self nodeToCast: exprNode to: (formalType ifNil: [#sqInt])]
		ifFalse:
			[((exprNode isSend or: [exprNode isVariable])
			  and: [(self
					variableOfType: (targetMethod typeFor: argName in: self)
					acceptsValue: exprNode
					ofType: (self typeFor: exprNode in: aTMethod)) not]) ifTrue:
				[logger
					nextPutAll:
						'type mismatch for formal ', argName, ' and actual "', exprNode asString,
						'" when inlining ', targetMethod selector, ' in ', aTMethod selector, '. Use a cast.';
					cr; flush]. 
			exprNode]