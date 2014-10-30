gc - global
markObjects: objectsShouldBeUnmarked
	<inline: #never> "for profiling"
	"Mark all accessible objects.  "
	"If the incremental collector is running mark bits may be set; stop it and clear them if necessary."
	self cCode: '' inSmalltalk: [coInterpreter transcript nextPutAll: 'marking...'; flush].
	self runLeakCheckerForFullGC: true.

	self shutDownIncrementalGC: objectsShouldBeUnmarked.
	self initializeUnscannedEphemerons.
	self initializeMarkStack.
	self initializeWeaklingStack.
	self markAccessibleObjectsAndFireEphemerons.
	self expungeDuplicateAndUnmarkedClasses: true.
	self nilUnmarkedWeaklingSlots