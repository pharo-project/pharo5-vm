garbage collection
followForwardedMethods
	<api>
	<option: #SpurObjectMemory>
	<var: #cogMethod type: #'CogMethod *'>
	| cogMethod freedPIC |
	<var: #cogMethod type: #'CogMethod *'>
	freedPIC := false.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType = CMMethod ifTrue:
			[(objectMemory isForwarded: cogMethod methodObject) ifTrue:
				[cogMethod methodObject: (objectMemory followForwarded: cogMethod methodObject).
				 (objectMemory isYoungObject: cogMethod methodObject) ifTrue:
					[methodZone ensureInYoungReferrers: cogMethod]]].
		 cogMethod cmType = CMClosedPIC ifTrue:
			[(self followMethodReferencesInClosedPIC: cogMethod) ifTrue:
				[freedPIC := true.
				 methodZone freeMethod: cogMethod]].
		 cogMethod := methodZone methodAfter: cogMethod].
	freedPIC ifTrue:
		[self unlinkSendsToFree]