garbage collection
remapOop: objOop
	^(objectMemory shouldRemapOop: objOop)
		ifTrue: [objectMemory remapObj: objOop]
		ifFalse: [objOop]