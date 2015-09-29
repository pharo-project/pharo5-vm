*Cog-method prototypes
WeakKeyDictionaryPROTOTYPEfixCollisionsFrom: start
	"The element at start has been removed and replaced by nil.
	This method moves forward from there, relocating any entries
	that had been placed below due to collisions with this one."

	| element index |
	index := start.
	[ (element := array at: (index := index \\ array size + 1)) == nil ] whileFalse: [
		element key
			ifNil: [ 
				finalizer ifNotNil: [ finalizer value: element value ].
				array at: index put: nil.
				tally := tally - 1 ]
			ifNotNil: [ :key | "Don't let the key go away"
				| newIndex |
				(newIndex := self scanFor: key) = index ifFalse: [
					array 
						at: newIndex put: element;
						at: index put: nil ] ] ]