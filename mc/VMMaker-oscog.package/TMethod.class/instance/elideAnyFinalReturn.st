transformations
elideAnyFinalReturn
	"For super expansions we need to eliminate any final return to prevent premature exit.
	 Anything meaningful in the returned expression must be retained."

	| stmtList lastStmt |
	stmtList := parseTree statements asOrderedCollection.
	(lastStmt := stmtList last) isReturn ifTrue:
		[stmtList at: stmtList size put: lastStmt expression.
		parseTree setStatements: stmtList]