inlining
exitVar: exitVar label: exitLabel
	"Replace each return statement in this method with an assignment to the
	 exit variable followed by either a return or a goto to the given label.
	 Answer if a goto was generated."
	"Optimization: If exitVar is nil, the return value of the inlined method is not being used, so don't add the assignment statement."

	| labelUsed map eliminateReturnSelfs |
	labelUsed := false.
	map := Dictionary new.
	"Conceivably one might ^self from a struct class and mean it.  In most cases though
	 ^self means `get me outta here, fast'.  So unless this method is from a VMStruct class,
	 elide any ^self's"
	eliminateReturnSelfs := ((definingClass inheritsFrom: VMClass) and: [definingClass isStructClass]) not
							  and: [returnType = #void or: [returnType = #sqInt]].
	parseTree nodesDo:
		[:node | | replacement |
		node isReturn ifTrue:
			[replacement := (node expression isVariable "Eliminate ^self's"
							   and: [node expression name = 'self'
							   and: [eliminateReturnSelfs]])
								ifTrue: [nil]
								ifFalse:
									[exitVar
										ifNil: [node expression]
										ifNotNil: [TAssignmentNode new
													setVariable: (TVariableNode new setName: exitVar)
													expression: node expression]].
			 node ~~ parseTree statements last ifTrue:
				[replacement := replacement
									ifNil: [TGoToNode new setLabel: exitLabel; yourself]
									ifNotNil:
										[TStmtListNode new
											setArguments: #()
											statements: {replacement.
														  TGoToNode new setLabel: exitLabel; yourself};
											yourself].
				 labelUsed := true].
			map
				at: node
				put: (replacement ifNil:
						[TLabeledCommentNode new setComment: 'return ', node expression printString])]].
	parseTree replaceNodesIn: map.
	"Now flatten any new statement lists..."
	parseTree nodesDo:
		[:node| | list |
		(node isStmtList and: [node statements last isStmtList]) ifTrue:
			[list := node statements last statements.
			 node statements removeLast; addAllLast: list]].
	^labelUsed