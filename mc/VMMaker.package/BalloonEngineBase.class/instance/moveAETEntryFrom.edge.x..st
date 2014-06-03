AET processing
moveAETEntryFrom: index edge: edge x: xValue
	"The entry at index is not in the right position of the AET. 
	Move it to the left until the position is okay."
	| newIndex |
	<inline: false>
	newIndex := index.
	[newIndex > 0 and:[(self edgeXValueOf: (aetBuffer at: newIndex-1)) > xValue]]
		whileTrue:[	aetBuffer at: newIndex put: (aetBuffer at: newIndex-1).
					newIndex := newIndex - 1].
	aetBuffer at: newIndex put: edge.