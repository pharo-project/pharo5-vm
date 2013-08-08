transformations
prepareMethodIn: aCodeGen
	"Record sends of builtin operators, map sends of the special selector dispatchOn:in:
	 with case statement nodes, and map sends of caseOf:[otherwise:] to switch statements.
	 Note: Only replaces top-level sends of dispatchOn:in: et al and caseOf:[otherwise:].
	 These must be top-level statements; they cannot appear in expressions.
	 As a hack also update the types of variables introduced to implement cascades correctly.
	 This has to be done at teh same time as this is done, so why not piggy back here?"
	| replacements |.
	cascadeVariableNumber ifNotNil:
		[declarations keysAndValuesDo:
			[:varName :decl|
			decl isBlock ifTrue:
				[self assert: ((varName beginsWith: 'cascade') and: [varName last isDigit]).
				 locals add: varName.
				 self declarationAt: varName
					put: (decl value: self value: aCodeGen), ' ', varName]]].
	replacements := IdentityDictionary new.
	aCodeGen
		pushScope: declarations
		while:
			[parseTree nodesDo:
				[:node|
				 node isSend ifTrue:
					[(aCodeGen isBuiltinSelector: node selector)
						ifTrue:
							[node isBuiltinOperator: true.
							"If a to:by:do:'s limit has side-effects, declare the limit variable, otherwise delete it from the args"
							 (node selector = #to:by:do:
							  and: [node args size = 4]) ifTrue:
								[| limitExpr |
								 limitExpr := node args first.
								 (limitExpr anySatisfy:
										[:subNode|
										subNode isSend
										and: [(aCodeGen isBuiltinSelector: subNode selector) not
										and: [(subNode isStructSend: aCodeGen) not]]])
									ifTrue: [locals add: node args last name]
									ifFalse:
										[node arguments: node args allButLast]]]
						ifFalse:
							[(CaseStatements includes: node selector) ifTrue:
								[replacements at: node put: (self buildCaseStmt: node)].
							 (#(caseOf: #caseOf:otherwise:) includes: node selector) ifTrue:
								[replacements at: node put: (self buildSwitchStmt: node)]]].
				 ((node isAssignment or: [node isReturn])
				  and: [node expression isSwitch]) ifTrue:
					[replacements at: node put: (self transformSwitchExpression: node)]]].
	replacements isEmpty ifFalse:
		[parseTree := parseTree replaceNodesIn: replacements]