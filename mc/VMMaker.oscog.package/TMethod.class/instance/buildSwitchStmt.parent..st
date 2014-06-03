transformations
buildSwitchStmt: aSendNode parent: parentNode
	"Build a switch statement node for the given send of caseOf: or caseOf:otherwise:."
	| switch |
	switch := TSwitchStmtNode new
				expression: aSendNode receiver
				cases: aSendNode args first
				otherwiseOrNil: (aSendNode args at: 2 ifAbsent: [nil]).
	(aSendNode receiver isVariable or: [parentNode isStmtList]) ifFalse:
		[switch switchVariable: (locals add: (self extraVariableName: 'switch'))].
	^switch