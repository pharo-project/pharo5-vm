printing
printOn: aStream level: level
	| possiblyParenthesize |
	possiblyParenthesize :=
		[:node :newLevel|
		(node isSend
		 and: [node selector precedence >= 3]) ifTrue:
			[aStream nextPut: $(].
		node printOn: aStream level: newLevel.
		(node isSend
		 and: [node selector precedence >= 3]) ifTrue:
			[aStream nextPut: $)]].

	possiblyParenthesize value: receiver value: level.
	arguments size = 0 ifTrue:
		[aStream space; nextPutAll: selector.
		^self].
	selector keywords with: (arguments first: selector numArgs) do:
		[:keyword :arg |
		aStream space; nextPutAll: keyword; space.
		possiblyParenthesize value: arg value: level + 1]