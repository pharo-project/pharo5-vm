AET processing
resortFirstAETEntry
	| edge xValue leftEdge |
	<inline: false>
	self aetStartGet = 0 ifTrue:[^nil]. "Nothing to resort"
	edge := aetBuffer at: self aetStartGet.
	xValue := self edgeXValueOf: edge.
	leftEdge := aetBuffer at: (self aetStartGet - 1).
	(self edgeXValueOf: leftEdge) <= xValue ifTrue:[^nil]. "Okay"
	self moveAETEntryFrom: self aetStartGet edge: edge x: xValue.