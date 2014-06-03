transformations
elideAnyFinalReturn
	"For super expansions we need to eliminate any final return to prevent premature exit.
	 Anything meaningful in the returned expression must be retained."

	| stmtList expr |
	stmtList := parseTree statements asOrderedCollection.
	stmtList last isReturn ifTrue:
		[expr := stmtList last expression.
		 (expr isVariable and: [expr name = 'self'])
			ifTrue: [stmtList := stmtList allButLast]
			ifFalse: [stmtList at: stmtList size put: expr].
		parseTree setStatements: stmtList]