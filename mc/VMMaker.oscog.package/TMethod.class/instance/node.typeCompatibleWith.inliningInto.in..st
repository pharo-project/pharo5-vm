inlining
node: exprNode typeCompatibleWith: argName inliningInto: inlineSelector in: aCodeGen
	"Answer either exprNode or, iff argName is typed and exprNode is untyped, a cast of exprNode to the type of argName."
	| formalType actualType |
	^((exprNode isSend or: [exprNode isVariable])
	   and: [(formalType := self typeFor: argName in: aCodeGen) notNil
	   and: [(actualType := aCodeGen typeFor: exprNode in: self) isNil
			or: [(aCodeGen variableOfType: formalType acceptsValueOfType: actualType) not]]])
		ifTrue: [aCodeGen nodeToCast: exprNode to: formalType]
		ifFalse:
			[((exprNode isSend or: [exprNode isVariable])
			  and: [(aCodeGen
					variableOfType: (aCodeGen typeFor: exprNode in: self)
					acceptsValueOfType: (self typeFor: argName in: aCodeGen)) not]) ifTrue:
				[aCodeGen logger
					nextPutAll:
						'type mismatch for formal ', argName, ' and actual ', exprNode asString,
						' when inlining ', inlineSelector, ' in ', selector, '. Use a cast.';
					cr; flush]. 
			exprNode]