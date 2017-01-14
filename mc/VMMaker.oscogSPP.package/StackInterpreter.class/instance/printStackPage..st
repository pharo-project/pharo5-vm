debug printing
printStackPage: page
	<inline: true>
	<var: #page type: #'StackPage *'>
	self printStackPage: page useCount: -1