inlining support
propagateReturnIn: aCodeGen
	"Propagate the return type to all return nodes"
	| map coercionType |
	returnType = #void ifTrue:
		[^self].
	"The following is necessary for functions returning functions, which have problematic syntax"
	coercionType := aCodeGen
							extractTypeFor: (aCodeGen cFunctionNameFor: self selector)
							fromDeclaration: returnType.
	map := IdentityDictionary new.
	parseTree nodesDo:[:node|
		(node isReturn
		 and: [(aCodeGen typeFor: node expression in: self) ~= coercionType]) ifTrue:
			[map at: node expression put: (TSendNode new
				setSelector: #cCoerce:to:
				receiver: (TVariableNode new setName: 'self')
				arguments: {node expression.
							TConstantNode new setValue: coercionType})]].
	self replaceNodesIn: map