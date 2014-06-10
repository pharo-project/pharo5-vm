printing
printCogMethodsWithSelector: selectorOop
	<api>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[(cogMethod cmType ~= CMFree
		  and: [cogMethod selector = selectorOop]) ifTrue:
			[coInterpreter printCogMethod: cogMethod].
		 cogMethod := self methodAfter: cogMethod]