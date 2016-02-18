calling convention
selectorIndexDereferenceRoutine
	"If the object representation is 64-bits, selectors must be accessed via indices in the inline caches.
	 Answer the routine that will map from indices to selector objects if so, otherwise nil."
	^nil