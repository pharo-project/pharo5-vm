printing
printCogMethodFor: address
	<api>
	<var: #address type: #'void *'>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := methodZone methodFor: address.
	cogMethod = 0
		ifTrue: [(self codeEntryFor: address)
					ifNil: [coInterpreter print: 'not a method'; cr]
					ifNotNil: [coInterpreter print: 'trampoline '; print: (self codeEntryNameFor: address); cr]]
		ifFalse: [coInterpreter printCogMethod: cogMethod]