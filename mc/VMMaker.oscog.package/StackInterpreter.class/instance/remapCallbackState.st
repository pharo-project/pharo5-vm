object memory support
remapCallbackState
	"Callback support - trace suspended callback list"
	1 to: jmpDepth do:
		[:i| | oop |
		oop := suspendedCallbacks at: i.
		(objectMemory shouldRemapOop: oop) ifTrue:
			[suspendedCallbacks at: i put: (objectMemory remapObj: oop)].
		oop := suspendedMethods at: i.
		(objectMemory shouldRemapObj: oop) ifTrue:
			[suspendedMethods at: i put: (objectMemory remapObj: oop)]]