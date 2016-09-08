garbage collection
markLiteralsAndUnlinkUnmarkedSendsIn: cogMethod
	"Unlink sends that have unmarked classes in inline caches or freed/freeable targets.
	 Nil-out inline caches linked to open PICs.
	 Assert that any selectors are marked.  We can do this since
	 this is only run on marked methods and thus any selectors they
	 reference should already be marked."
	<var: #cogMethod type: #'CogMethod *'>
	<inline: true>
	self assert: cogMethod cmType = CMMethod.
	self assert: (objectMemory isMarked: cogMethod methodObject).
	objectRepresentation
		markAndTraceLiteral: cogMethod selector
		in: cogMethod
		at: (self addressOf: cogMethod selector put: [:val| cogMethod selector: val]).
	self maybeMarkCountersIn: cogMethod.
	self maybeMarkIRCsIn: cogMethod.
	self mapFor: cogMethod
		 performUntil: #markLiteralsAndUnlinkIfUnmarkedSend:pc:method:
		 arg: cogMethod asInteger