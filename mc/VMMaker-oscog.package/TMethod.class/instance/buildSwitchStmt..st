transformations
buildSwitchStmt: aSendNode
	"Build a switch statement node for the given send of caseOf: or caseOf:otherwise:."

	^TSwitchStmtNode new
		expression: aSendNode receiver
		cases: aSendNode args first
		otherwiseOrNil: (aSendNode args at: 2 ifAbsent: [nil])