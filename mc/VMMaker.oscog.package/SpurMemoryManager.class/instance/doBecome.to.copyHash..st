become implementation
doBecome: obj1 to: obj2 copyHash: copyHashFlag
	"one-way become with or without copying obj1's hash into obj2.
	 Straight-forward, even for classes.  With classes we end up with two entries
	 for obj2.  Which is current depends on copyHashFlag.  If copyHashFlag is true
	 then the entry at obj1's hash is valid, otherwise the the existing one at obj2's
	 hash.  When all the instances with the old hash have been collected, the GC will
	 discover this and expunge obj2 at the unused index (see markAndTraceClassOf:)."
	self forward: obj1 to: obj2.
	copyHashFlag ifTrue: [self setHashBitsOf: obj2 to: (self rawHashBitsOf: obj1)].
	((self isOldObject: obj1)
	 and: [self isYoung: obj2]) ifTrue:
		[becomeEffectsFlags := becomeEffectsFlags bitOr: OldBecameNewFlag].
	self deny: (self isOopForwarded: obj2)