callout support
ffiAtomicStructByReference: oop Class: oopClass in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	"Support for generic callout. Prepare an external pointer reference to an atomic type for callout."
	| atomicType err valueOop |
	<inline: true>
	"must be external data to pass pointers to atomic type"
	oopClass = interpreterProxy classExternalData 
		ifFalse:[^FFIErrorCoercionFailed].
	atomicType := self atomicTypeOf: calloutState ffiArgHeader.
	"no type checks for void pointers"
	atomicType ~= FFITypeVoid ifTrue:[
		err := self ffiValidateExternalData: oop AtomicType: atomicType.
		err ~= 0 ifTrue:[^err].
	].
	"and push pointer contents"
	valueOop := interpreterProxy fetchPointer: 0 ofObject: oop.
	^self ffiPushPointerContentsOf: valueOop in: calloutState