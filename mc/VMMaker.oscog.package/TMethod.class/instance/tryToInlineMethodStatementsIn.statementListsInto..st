inlining
tryToInlineMethodStatementsIn: aCodeGen statementListsInto: aBlock
	"Expand any (complete) inline methods sent by this method as top-level statements.
	 Answer if anything was inlined."

	| stmtLists didSomething newStatements returningNodes |
	didSomething := false.
	returningNodes := Set new.
	parseTree nodesDo:
		[:node|
		node isReturn ifTrue:
			[returningNodes add: node expression.
			 node expression isConditionalSend ifTrue:
				[returningNodes addAll: (node expression args collect: [:stmtList| stmtList statements last])]]].
	stmtLists := self statementsListsForInliningIn: aCodeGen.
	stmtLists do:
		[:stmtList|
		newStatements := OrderedCollection new: stmtList statements size.
		stmtList statements do:
			[:stmt|
			(self inlineCodeOrNilForStatement: stmt returningNodes: returningNodes in: aCodeGen)
				ifNil: [newStatements addLast: stmt]
				ifNotNil: [:inlinedStmts|
					didSomething := true.
					newStatements addAllLast: inlinedStmts]].
		stmtList setStatements: newStatements asArray].

	"This is a hack; forgive me. The inlining above tends to keep return statements in statement lists.
	 In the case of returning ifs we don't want the returns in case the returning if is generated as an expression."
	returningNodes do:
		[:returningNode|
		 (returningNode isConditionalSend
		  and: [returningNode args anySatisfy: [:alternativeNode| alternativeNode endsWithReturn]]) ifTrue:
			[returningNode args withIndexDo:
				[:alternativeNode :index|
				 alternativeNode endsWithReturn ifTrue:
					[returningNode args at: index put: alternativeNode copyWithoutReturn]]]].

	aBlock value: stmtLists.

	^didSomething