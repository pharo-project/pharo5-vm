initialization
initialEnterSmalltalkExecutive
	"Main entry-point into the interpreter at system start-up."
	"Ensure that the myList of the activeProcess is nil.  Needed to load
	 old images which don't nil myList in transferTo:{from:}"
	objectMemory storePointerUnchecked: MyListIndex ofObject: self activeProcess withValue: objectMemory nilObject.
	cogThreadManager startThreadSubsystem.
	self threadSchedulingLoop: (cogThreadManager vmThreadAt: 1)