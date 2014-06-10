printing
printCogMethodsOfType: cmType
	<api>
	<returnTypeC: #void>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[cogMethod cmType = cmType ifTrue:
			[coInterpreter printCogMethod: cogMethod].
		 cogMethod := self methodAfter: cogMethod]