jit - api
freeUnmarkedMachineCode
	"Free machine-code methods whose compiled methods are unmarked
	 and open PICs whose selectors are not marked, and closed PICs that
	 refer to unmarked objects."
	<api>
	<option: #SpurObjectMemory>
	| cogMethod freedMethod |
	<var: #cogMethod type: #'CogMethod *'>
	freedMethod := false.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[(cogMethod cmType = CMMethod
		  and: [(objectMemory isMarked: cogMethod methodObject) not]) ifTrue:
			[freedMethod := true.
			 methodZone freeMethod: cogMethod].
		 (cogMethod cmType = CMOpenPIC
		  and: [(objectMemory isImmediate: cogMethod selector) not
		  and: [(objectMemory isMarked: cogMethod selector) not]]) ifTrue:
			[freedMethod := true.
			 methodZone freeMethod: cogMethod].
		 (cogMethod cmType = CMClosedPIC
		  and: [self closedPICRefersToUnmarkedObject: cogMethod]) ifTrue:
			[freedMethod := true.
			 methodZone freeMethod: cogMethod].
		 cogMethod := methodZone methodAfter: cogMethod].
	freedMethod ifTrue:
		[self unlinkSendsToFree]