debug printing
printUnbalancedStack: primIdx
	<inline: false>
	self print: 'Stack unbalanced after '.
	successFlag 
		ifTrue:[self print:'successful primitive '] 
		ifFalse:[self print: 'failed primitive '].
	self printNum: primIdx.
	self cr.
		