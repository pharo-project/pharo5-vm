debugging
addCogMethodsToHeapMap
	<api>
	"Perform an integrity/leak check using the heapMap.
	 Set a bit at each cog method's header."	
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType = CMMethod ifTrue:
			[coInterpreter heapMapAtWord: cogMethod Put: 1].
		cogMethod := methodZone methodAfter: cogMethod]