enumerating
nodesSelect: selectBlock thenCollect: collectBlock
	| result |
	result := OrderedCollection new.
	self nodesDo:
		[:node|
		(selectBlock value: node) ifTrue:
			[result addLast: (collectBlock value: node)]].
	^result