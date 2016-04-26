method zone introspection
methodsCompiledToMachineCodeInto: arrayObj 
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	| cogMethod methodIndex |
	methodIndex := 0.
	cogMethod := cogit cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[cogMethod cmType = CMMethod ifTrue:
			[objectMemory 
				storePointerUnchecked: methodIndex 
				ofObject: arrayObj 
				withValue: cogMethod methodObject.
			 methodIndex := methodIndex + 1].
		 cogMethod := self methodAfter: cogMethod].
	^ methodIndex
	