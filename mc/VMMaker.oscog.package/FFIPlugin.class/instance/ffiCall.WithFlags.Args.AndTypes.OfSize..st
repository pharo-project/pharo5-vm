callout support
ffiCall: address WithFlags: callType Args: argArray AndTypes: argTypeArray OfSize: nArgs
	"Generic callout. Does the actual work."
	| argType argTypes oop argSpec argClass |
	<inline: true>
	"check if the calling convention is supported"
	(self ffiSupportsCallingConvention: callType)
		ifFalse:[^self ffiFail: FFIErrorCallType].
	argTypes := argTypeArray.
	"Fetch return type and args"
	argType := interpreterProxy fetchPointer: 0 ofObject: argTypes.
	argSpec := interpreterProxy fetchPointer: 0 ofObject: argType.
	argClass := interpreterProxy fetchPointer: 1 ofObject: argType.
	self ffiCheckReturn: argSpec With: argClass.
	interpreterProxy failed ifTrue:[^0]. "cannot return"
	ffiRetOop := argType.
	1 to: nArgs do:[:i|
		argType := interpreterProxy fetchPointer: i ofObject: argTypes.
		argSpec := interpreterProxy fetchPointer: 0 ofObject: argType.
		argClass := interpreterProxy fetchPointer: 1 ofObject: argType.
		oop := interpreterProxy fetchPointer: i-1 ofObject: argArray.
		self ffiArgument: oop Spec: argSpec Class: argClass.
		interpreterProxy failed ifTrue:[^0]. "coercion failed"
	].
	"Go out and call this guy"
	^self ffiCalloutTo: address WithFlags: callType