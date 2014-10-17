cleanup obsolete classes
isReallyObsolete: aClassDescription
	"Returns whether the argument class is *really* obsolete. (Due to a bug, the method isObsolete
	isObsolete does not always return the right answer"

	^ aClassDescription isObsolete or: [(aClassDescription superclass subclasses includes: aClassDescription) not]