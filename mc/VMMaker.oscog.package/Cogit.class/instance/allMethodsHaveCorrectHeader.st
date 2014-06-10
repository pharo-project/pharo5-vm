garbage collection
allMethodsHaveCorrectHeader
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType = CMMethod ifTrue:
			[(objectRepresentation hasValidHeaderPostGC: cogMethod) ifFalse:
				[^false]].
		 cogMethod := methodZone methodAfter: cogMethod].
	^true