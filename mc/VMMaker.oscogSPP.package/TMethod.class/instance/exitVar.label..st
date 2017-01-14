inlining
exitVar: exitVar label: exitLabel
	"Replace each return statement in this method with an assignment to the
	 exit variable followed by either a return or a goto to the given label.
	 Answer if a goto was generated."
	"Optimization: If exitVar is nil, the return value of the inlined method is not being used, so don't add the assignment statement."

	| labelUsed map elisions eliminateReturnSelfs |
	labelUsed := false.
	map := Dictionary new.
	elisions := Set new.
	"Conceivably one might ^self from a struct class and mean it.  In most cases though
	 ^self means `get me outta here, fast'.  So unless this method is from a VMStruct class,
	 elide any ^self's"
	eliminateReturnSelfs := ((definingClass inheritsFrom: VMClass) and: [definingClass isStructClass]) not
							  and: [returnType = #void or: [returnType = #sqInt]].
	parseTree nodesDo:
		[:node | | replacement |
		node isReturn ifTrue:
			[self transformReturnSubExpression: node
				toAssignmentOf: exitVar
				andGoto: exitLabel
				unless: eliminateReturnSelfs
				into: [:rep :labelWasUsed|
					replacement := rep.
					labelWasUsed ifTrue: [labelUsed := true]].
			"replaceNodesIn: is strictly top-down, so any replacement for ^expr ifTrue: [...^fu...] ifFalse: [...^bar...]
			 will prevent replacement of either ^fu or ^bar. The corollary is that ^expr ifTrue: [foo] ifFalse: [^bar]
			 must be transformed into expr ifTrue: [^foo] ifFalse: [^bar]"
			(node expression isConditionalSend
			 and: [node expression hasExplicitReturn])
				ifTrue:
					[elisions add: node.
					 (node expression args reject: [:arg| arg endsWithReturn]) do:
						[:nodeNeedingReturn|
						 self transformReturnSubExpression: nodeNeedingReturn statements last
							toAssignmentOf: exitVar
							andGoto: exitLabel
							unless: eliminateReturnSelfs
							into: [:rep :labelWasUsed|
								replacement := rep.
								labelWasUsed ifTrue: [labelUsed := true]].
						 map
							at: nodeNeedingReturn statements last
							put: replacement]]
				ifFalse:
					[map
						at: node
						put: (replacement ifNil:
								[TLabeledCommentNode new setComment: 'return ', node expression printString])]]].
	map isEmpty ifTrue:
		[self deny: labelUsed.
		 ^false].
	"Now do a top-down replacement for all returns that should be mapped to assignments and gotos"
	parseTree replaceNodesIn: map.
	"Now it is safe to eliminate the returning ifs..."
	elisions isEmpty ifFalse:
		[| elisionMap |
		 elisionMap := Dictionary new.
		 elisions do: [:returnNode| elisionMap at: returnNode put: returnNode expression].
		 parseTree replaceNodesIn: elisionMap].
	"Now flatten any new statement lists..."
	parseTree nodesDo:
		[:node| | list |
		(node isStmtList
		 and: [node statements notEmpty
		 and: [node statements last isStmtList]]) ifTrue:
			[list := node statements last statements.
			 node statements removeLast; addAllLast: list]].
	^labelUsed