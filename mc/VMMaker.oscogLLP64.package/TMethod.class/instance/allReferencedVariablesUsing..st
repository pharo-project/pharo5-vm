accessing
allReferencedVariablesUsing: aCodeGen
	"Answer the set of all variables referenced in the receiver."
	| refs |
	refs := Set new.
	"Find all the variable names referenced in this method.
	 Don't descend into conditionals that won't be generated."
	parseTree
		nodesWithParentsDo:
			[:node :parent|
			node isVariable ifTrue: [refs add: node name asString].
			node isStmtList ifTrue: [refs addAll: node args].
			(node isSend
			 and: [node selector beginsWith: #cCode:]) ifTrue:
				[aCodeGen addVariablesInVerbatimCIn: node to: refs]]
		unless:
			[:node :parent|
			parent notNil
			and: [parent isSend
			and: [aCodeGen nodeIsDeadCode: node withParent: parent]]].
	^refs