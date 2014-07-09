initialize
doneCompiling: aClass
	"The receiver has finished modifying the class hierarchy.
	Do any necessary cleanup."
	aClass doneCompiling.
	Behavior flushObsoleteSubclasses.