type inference
transformVoidReturns
	"Once the return type has been found or inferred to be #void,
	 any occurrences of ^expr must be replaced with expr. ^self."
	self assert: returnType == #void.
	parseTree nodesWithParentsDo:
		[:node :parent|
		(node isReturn
		 and: [node expression isVariable not
			or: [node expression name ~= 'self']]) ifTrue:
			[parent
				replaceChild: node
				with: (TStmtListNode new
						setArguments: #()
						statements: {node expression.
									  TReturnNode new 
										setExpression: (TVariableNode new setName: 'self')
										yourself})]]