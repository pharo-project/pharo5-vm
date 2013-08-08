garbage collection
markAndTraceOrFreeCogMethod: cogMethod firstVisit: firstVisit
	"Mark and trace objects in the argument and free if it is appropriate.
	 Answer if the method has been freed.  firstVisit is a hint used to avoid
	 scanning methods we've already seen.  False positives are fine.
	 For a CMMethod this
			frees if the bytecode method isnt marked,
			marks and traces object literals and selectors,
			unlinks sends to targets that should be freed.
	 For a CMClosedPIC this
			frees if it refers to anything that should be freed or isn't marked.
	 For a CMOpenPIC this
			frees if the selector isn't marked."
	<var: #cogMethod type: #'CogMethod *'>
	<inline: false> "this recurses at most one level down"
	cogMethod cmType = CMFree ifTrue:
		[^true].
	self assert: (self cogMethodDoesntLookKosher: cogMethod) = 0.
	cogMethod cmType = CMMethod ifTrue:
		[(objectMemory isMarked: cogMethod methodObject) ifFalse:
			[methodZone freeMethod: cogMethod.
			 ^true].
		 firstVisit ifTrue:
			[self markLiteralsAndUnlinkUnmarkedSendsIn: cogMethod].
		^false].
	cogMethod cmType = CMClosedPIC ifTrue:
		[(self closedPICRefersToUnmarkedObject: cogMethod) ifFalse:
			[^false].
		 methodZone freeMethod: cogMethod.
		 ^true].
	cogMethod cmType = CMOpenPIC ifTrue:
		[(objectMemory isMarked: cogMethod selector) ifTrue:
			[^false].
		 methodZone freeMethod: cogMethod.
		 ^true].
	self assert: (cogMethod cmType = CMMethod
				or: [cogMethod cmType = CMClosedPIC
				or: [cogMethod cmType = CMOpenPIC]]).
	^false