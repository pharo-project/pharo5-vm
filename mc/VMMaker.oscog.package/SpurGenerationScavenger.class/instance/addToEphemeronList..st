weakness and ephemerality
addToEphemeronList: ephemeronCorpse
	"ephemeronCorpse is the corpse of an ephemeron that was copied and forwarded.
	 Later on its surviving copy must be scanned to nil weak references.
	 Thread the corpse onto the weakList.  Later, the weakList can be followed, and
	 the forwarding pointer followed to locate the survivor."
	<inline: #never> "Should be too infrequent to lower icache density of copyAndForward:"
	| ephemeronListOffset |
	self assert: (self isScavengeSurvivor: (manager keyOfEphemeron: (manager followForwarded: ephemeronCorpse))) not.

	ephemeronListOffset := ephemeronList ifNil: 0.
	self setCorpseOffsetOf: ephemeronCorpse to: ephemeronListOffset.
	ephemeronList := self corpseOffsetOf: ephemeronCorpse.
	self assert: (self firstCorpse: ephemeronList) = ephemeronCorpse