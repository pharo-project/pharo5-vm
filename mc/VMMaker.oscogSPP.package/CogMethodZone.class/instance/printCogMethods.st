printing
printCogMethods
	<api>
	<returnTypeC: #void>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[coInterpreter printCogMethod: cogMethod.
		 cogMethod := self methodAfter: cogMethod]