printing
printCogMethodFor: address
	<api>
	<var: #address type: #'void *'>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := methodZone methodFor: address.
	cogMethod = 0
		ifTrue: [coInterpreter print: 'not a method'; cr]
		ifFalse: [coInterpreter printCogMethod: cogMethod]