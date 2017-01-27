debug printing
printOopsSuchThat: function
	<api>
	<var: #function declareC: 'sqInt (*function)(sqInt)'>
	self allHeapEntitiesDo:
		[:o|
		(self perform: function with: o) ifTrue:
			[self printEntity: o]]