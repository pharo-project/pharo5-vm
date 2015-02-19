spur primitive compilation
actualsForMethod: aTMethod
	"Normal primitives have no arguments, but translated primitives do.
	 This class doesn't handle translated primitives and so smply answers an empty array.
	 Subclasses override as required."
	^#()