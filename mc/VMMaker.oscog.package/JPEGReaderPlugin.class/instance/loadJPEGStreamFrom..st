stream support
loadJPEGStreamFrom: streamOop
	| oop sz |
	(interpreterProxy isPointers: streamOop) ifFalse:[^false].
	(interpreterProxy slotSizeOf: streamOop) < 5 ifTrue:[^false].
	oop := interpreterProxy fetchPointer: 0 ofObject: streamOop.
	(interpreterProxy isBytes: oop) ifFalse:[^false].
	jsCollection := interpreterProxy firstIndexableField: oop.
	sz := interpreterProxy byteSizeOf: oop.
	jsPosition := interpreterProxy fetchInteger: 1 ofObject: streamOop.
	jsReadLimit := interpreterProxy fetchInteger: 2 ofObject: streamOop.
	jsBitBuffer := interpreterProxy fetchInteger: 3 ofObject: streamOop.
	jsBitCount := interpreterProxy fetchInteger: 4 ofObject: streamOop.
	interpreterProxy failed ifTrue:[^false].
	sz < jsReadLimit ifTrue:[^false].
	(jsPosition < 0 or:[jsPosition >= jsReadLimit]) ifTrue:[^false].
	^true