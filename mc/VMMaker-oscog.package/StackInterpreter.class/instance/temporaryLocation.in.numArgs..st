internal interpreter access
temporaryLocation: offset in: theFP numArgs: numArgs
	"Answer the pointer to a given temporary (for debug frame printing in odd circumstances)"
	<var: #theFP type: #'char *'>
	<returnTypeC: #'char *'>
	<asmLabel: false>
	^offset < numArgs
		ifTrue: [theFP + FoxCallerSavedIP + ((numArgs - offset) * BytesPerWord)]
		ifFalse: [theFP + FoxReceiver - BytesPerWord + ((numArgs - offset) * BytesPerWord)]