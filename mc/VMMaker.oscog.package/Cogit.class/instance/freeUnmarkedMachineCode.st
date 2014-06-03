jit - api
freeUnmarkedMachineCode
	"Free machine-code methods whose compiled methods are unmarked
	 and open PICs whose selectors are not marked."
	<api>
	<option: #SpurMemoryManager>
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
		 cogMethod := methodZone methodAfter: cogMethod].
	freedMethod ifTrue:
		[self unlinkSendsToFree.
		 methodZone pruneYoungReferrers.
		 processor flushICacheFrom: codeBase to: methodZone limitZony asInteger]