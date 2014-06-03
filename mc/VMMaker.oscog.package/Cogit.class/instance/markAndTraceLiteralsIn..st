garbage collection
markAndTraceLiteralsIn: cogMethod
	<option: #SpurMemoryManager>
	"Unlink sends that have unmarked classes in inline caches or freed/freeable targets.
	 Nil-out inline caches linked to open PICs.
	 Assert that any selectors are marked.  We can do this since
	 this is only run on marked methods and thus any selectors they
	 reference should already be marked."
	<var: #cogMethod type: #'CogMethod *'>
	<inline: true>
	self assert: ((cogMethod cmType = CMMethod
				 and: [objectMemory isMarked: cogMethod methodObject])
				 or: [cogMethod cmType = CMOpenPIC
				 and: [(objectMemory isImmediate: cogMethod selector)
					or: [objectMemory isMarked: cogMethod selector]]]).
	objectRepresentation markAndTraceLiteral: cogMethod selector.
	self mapFor: cogMethod
		 performUntil: #markLiterals:pc:method:
		 arg: cogMethod asInteger