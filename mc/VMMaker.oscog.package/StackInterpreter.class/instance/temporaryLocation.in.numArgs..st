internal interpreter access
temporaryLocation: offset in: theFP numArgs: numArgs
	"Answer the pointer to a given temporary (for debug frame printing in odd circumstances)"
	<var: #theFP type: #'char *'>
	<returnTypeC: #'char *'>
	^offset < numArgs
		ifTrue: [theFP + FoxCallerSavedIP + ((numArgs - offset) * objectMemory wordSize)]
		ifFalse: [theFP + FoxReceiver - objectMemory wordSize + ((numArgs - offset) * objectMemory wordSize)]