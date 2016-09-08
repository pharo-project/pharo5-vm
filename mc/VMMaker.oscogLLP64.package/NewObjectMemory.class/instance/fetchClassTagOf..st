interpreter access
fetchClassTagOf: oop
	"Compatibility with SpurObjectMemory.  In ObjectMemory there is no distinction between a
	 classTag in the first-level method cache and a class itself."
	^self fetchClassOf: oop