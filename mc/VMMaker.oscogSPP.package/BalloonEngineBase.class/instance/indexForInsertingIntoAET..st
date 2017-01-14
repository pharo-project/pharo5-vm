AET processing
indexForInsertingIntoAET: edge
	"Find insertion point for the given edge in the AET"
	| initialX index |
	<inline: false>
	initialX := self edgeXValueOf: edge.
	index := 0.
	[index < self aetUsedGet and:[
		(self edgeXValueOf: (aetBuffer at: index)) < initialX]]
			whileTrue:[index := index + 1].
	[index < self aetUsedGet and:[
		(self edgeXValueOf: (aetBuffer at: index)) = initialX and:[
			(self getSorts: (aetBuffer at: index) before: edge)]]]
				whileTrue:[index := index + 1].
	^index