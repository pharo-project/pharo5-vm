gc -- compaction
existImmutableReferencesToForwardedInRangeFrom: memStart to: memEnd
	"Answer if any immutable objects refer to any forwarded objects so that the become: primitives can fail if a become would update a reference from an immutable object."

	| oop |
	1 to: rootTableCount do:
		[:i | 
		oop := rootTable at: i.
		(oop < memStart or: [oop >= memEnd]) ifTrue:
			["Note: must not remap the fields of any object twice!"
			"remap this oop only if not in the memory range 
			covered below"
			(self objectIsImmutableAndReferencesForwarded: oop) ifTrue:
				[^true]]].

	oop := self oopFromChunk: memStart.
	[oop < memEnd] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[(self objectIsImmutableAndReferencesForwarded: oop) ifTrue:
				[^true]].
		oop := self objectAfterWhileForwarding: oop].
	^false