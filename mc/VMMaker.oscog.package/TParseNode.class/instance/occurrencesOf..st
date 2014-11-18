enumerating
occurrencesOf: aNode
	| count |
	count := 0.
	self nodesDo:
		[:node|
		node = aNode ifTrue: [count := count + 1]].
	^count