printing
cogMethodsSelect: aBlock
	<doNotGenerate>
	| cogMethod cogMethods |
	cogMethods := OrderedCollection new: 256.
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[(aBlock value: cogMethod) ifTrue:
			[cogMethods addLast: cogMethod].
		 cogMethod := self methodAfter: cogMethod].
	^cogMethods