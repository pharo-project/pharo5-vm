testing
hasExplicitReturn

	self nodesDo: [ :node |
		node isReturn ifTrue: [ ^true ].
	].
	^false