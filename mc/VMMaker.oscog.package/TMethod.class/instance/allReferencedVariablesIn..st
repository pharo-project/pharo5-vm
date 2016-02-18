accessing
allReferencedVariablesIn: aCodeGen
	"Answer the set of all variables referenced in the receiver."
	| refs |
	refs := Set new.
	"Find all the variable names referenced in this method.
	 Don't descend into "
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
			(aCodeGen nilOrBooleanConditionFor: parent)
				ifNil: [false]
				ifNotNil:
					[:condition| "double negatives are confusing, aren't they ;-)"
					node = parent args second == condition not]].
	^refs