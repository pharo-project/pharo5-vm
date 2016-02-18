printing
printCogYoungReferrers
	<api>
	<returnTypeC: #void>
	| pointer cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	pointer := youngReferrers.
	[pointer < limitAddress] whileTrue:
		[cogMethod := coInterpreter cCoerceSimple: (objectMemory longAt: pointer) to: #'CogMethod *'.
		 cogMethod cmRefersToYoung ifFalse:
			[coInterpreter print: '*'].
		 cogMethod cmType = CMFree ifTrue:
			[coInterpreter print: '!'].
		 (cogMethod cmRefersToYoung and: [cogMethod cmType ~= CMFree]) ifFalse:
			[coInterpreter print: ' '].
		 coInterpreter printCogMethod: cogMethod.
		 pointer := pointer + objectMemory wordSize]