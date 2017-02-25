gc - global
markObjects: objectsShouldBeUnmarkedAndUnmarkedClassesShouldBeExpunged
	<inline: #never> "for profiling"
	"Mark all accessible objects.  objectsShouldBeUnmarkedAndUnmarkedClassesShouldBeExpunged
	 is true if all objects are unmarked and/or if unmarked classes shoud be removed from the class table."
	"If the incremental collector is running mark bits may be set; stop it and clear them if necessary."
	self cCode: '' inSmalltalk: [coInterpreter transcript nextPutAll: 'marking...'; flush].
	self runLeakCheckerFor: GCModeFull.

	self shutDownIncrementalGC: objectsShouldBeUnmarkedAndUnmarkedClassesShouldBeExpunged.
	self initializeUnscannedEphemerons.
	self initializeMarkStack.
	self initializeWeaklingStack.
	marking := true.
	self markAccessibleObjectsAndFireEphemerons.
	self expungeDuplicateAndUnmarkedClasses: objectsShouldBeUnmarkedAndUnmarkedClassesShouldBeExpunged.
	self nilUnmarkedWeaklingSlots.
	marking := false