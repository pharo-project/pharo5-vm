inlining
transformReturnSubExpression: node toAssignmentOf: exitVar andGoto: exitLabel unless: eliminateReturnSelfs into: aBinaryBlock
	| expr replacement |
	expr := node isReturn ifTrue: [node expression] ifFalse: [node].
	replacement := (expr isVariable "Eliminate ^self's"
					   and: [expr name = 'self'
					   and: [eliminateReturnSelfs]])
						ifTrue: [nil]
						ifFalse:
							[exitVar
								ifNil: [expr]
								ifNotNil: [TAssignmentNode new
											setVariable: (TVariableNode new setName: exitVar)
											expression: expr]].
	 node == parseTree statements last
		ifTrue:
			[aBinaryBlock value: replacement value: false]
		ifFalse:
			[replacement := replacement
								ifNil: [TGoToNode new setLabel: exitLabel; yourself]
								ifNotNil:
									[TStmtListNode new
										setArguments: #()
										statements: {replacement.
													  TGoToNode new setLabel: exitLabel; yourself};
										yourself].
			 aBinaryBlock value: replacement value: true]