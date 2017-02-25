printing
printCogMethodsWithPrimitive: primIdx
	<api>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[(cogMethod cmType = CMMethod
		  and: [primIdx = (coInterpreter primitiveIndexOfMethod: cogMethod methodObject
							header: cogMethod methodHeader)]) ifTrue:
			[coInterpreter printCogMethod: cogMethod].
		 cogMethod := self methodAfter: cogMethod]