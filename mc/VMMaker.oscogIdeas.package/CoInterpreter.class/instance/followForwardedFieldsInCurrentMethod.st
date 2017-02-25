message sending
followForwardedFieldsInCurrentMethod
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	<inline: false>
	(self isMachineCodeFrame: framePointer)
		ifTrue:
			[cogMethod := self mframeHomeMethod: framePointer.
			 objectMemory
				followForwardedObjectFields: cogMethod methodObject
				toDepth: 0.
			 cogit followForwardedLiteralsIn: cogMethod]
		ifFalse:
			[objectMemory
				followForwardedObjectFields: method
				toDepth: 0]