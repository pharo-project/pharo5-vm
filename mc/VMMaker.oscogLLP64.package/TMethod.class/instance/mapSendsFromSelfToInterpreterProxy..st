transformations
mapSendsFromSelfToInterpreterProxy: selectors
	| interpreterProxyNode |
	interpreterProxyNode := TVariableNode new setName: 'interpreterProxy'.
	parseTree nodesDo:
		[:node|
		(node isSend
		and: [node receiver isVariable
		and: [node receiver name = 'self'
		and: [selectors includes: node selector]]]) ifTrue:
			[node receiver: interpreterProxyNode]]