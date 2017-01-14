type inference
transformReturns
	"Once the return type has been found or inferred, returns may bneed to be modified.
	 If the return type is #void, any occurrences of ^expr must be replaced with expr. ^self.
	 If the type is #sqInt any any occurrences of ^self are replaced with ^0."
	(returnType == #void or: [returnType == #sqInt]) ifFalse:
		[^self].
	parseTree nodesWithParentsDo:
		[:node :parent|
		node isReturn ifTrue:
			[(node expression isVariable and: [node expression name = 'self'])
				ifTrue:
					[returnType = #sqInt ifTrue:
						[node setExpression: (TConstantNode new setValue: 0)]]
				ifFalse:
					[returnType = #void ifTrue:
						[parent
							replaceChild: node
							with: (TStmtListNode new
									setArguments: #()
									statements: {node expression.
												  TReturnNode new 
													setExpression: (TVariableNode new setName: 'self')
													yourself})]]]]