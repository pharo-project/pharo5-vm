accessing
addStructClasses: classes
	"Add the struct classes and save them for emitCTypesOn: later."
	structClasses := classes.
	structClasses do:
		[:structClass|
		 (structClass withAllSuperclasses copyUpTo: VMStructType) do:
			[:structClassOrSuperclass|
			 self addStructClass: structClassOrSuperclass]]