inlining
nodeToCast: exprNode to: cType
	^TSendNode new
		setSelector: #cCoerceSimple:
		receiver: (TVariableNode new setName: 'self')
		arguments: { exprNode. TConstantNode new setValue: cType }
		isBuiltInOp: true