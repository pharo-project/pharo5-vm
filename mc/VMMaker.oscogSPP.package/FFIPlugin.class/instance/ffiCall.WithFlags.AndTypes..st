callout support
ffiCall: address WithFlags: callType AndTypes: argTypeArray
	"Generic callout. Does the actual work."
	| stackIndex argType argTypes oop nArgs argClass argSpec |
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
	nArgs := interpreterProxy methodArgumentCount.
	stackIndex := nArgs - 1. "stack index goes downwards"
	1 to: nArgs do:[:i|
		argType := interpreterProxy fetchPointer: i ofObject: argTypes.
		argSpec := interpreterProxy fetchPointer: 0 ofObject: argType.
		argClass := interpreterProxy fetchPointer: 1 ofObject: argType.
		oop := interpreterProxy stackValue: stackIndex.
		self ffiArgument: oop Spec: argSpec Class: argClass.
		interpreterProxy failed ifTrue:[^0]. "coercion failed"
		stackIndex := stackIndex - 1.
	].
	"Go out and call this guy"
	^self ffiCalloutTo: address WithFlags: callType