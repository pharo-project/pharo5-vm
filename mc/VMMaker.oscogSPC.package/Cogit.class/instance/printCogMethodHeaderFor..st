printing
printCogMethodHeaderFor: address
	<doNotGenerate>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := methodZone methodFor: address.
	cogMethod = 0
		ifTrue: [coInterpreter print: 'not a method'; cr]
		ifFalse: [self printMethodHeader: cogMethod on: coInterpreter transcript]