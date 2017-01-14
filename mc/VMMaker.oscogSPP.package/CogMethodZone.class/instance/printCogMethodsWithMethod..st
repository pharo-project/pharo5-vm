printing
printCogMethodsWithMethod: methodOop
	<api>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[(cogMethod cmType ~= CMFree
		  and: [cogMethod methodObject = methodOop]) ifTrue:
			[coInterpreter printCogMethod: cogMethod].
		 cogMethod := self methodAfter: cogMethod]