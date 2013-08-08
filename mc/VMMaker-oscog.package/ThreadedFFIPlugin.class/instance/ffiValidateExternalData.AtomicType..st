callout support
ffiValidateExternalData: oop AtomicType: atomicType
	"Validate if the given oop (an instance of ExternalData) can be passed as a pointer to the given atomic type."
	| ptrType specOop spec specType |
	<inline: true>
	ptrType := interpreterProxy fetchPointer: 1 ofObject: oop.
	(interpreterProxy isIntegerObject: ptrType)
		ifTrue:[^FFIErrorWrongType].
	(interpreterProxy isPointers: ptrType)
		ifFalse:[^FFIErrorWrongType].
	(interpreterProxy slotSizeOf: ptrType) < 2
		ifTrue:[^FFIErrorWrongType].
	specOop := interpreterProxy fetchPointer: 0 ofObject: ptrType.
	(interpreterProxy isIntegerObject: specOop)
		ifTrue:[^FFIErrorWrongType].
	(interpreterProxy isWords: specOop)
		ifFalse:[^FFIErrorWrongType].
	(interpreterProxy slotSizeOf: specOop) = 0
		ifTrue:[^FFIErrorWrongType].
	spec := interpreterProxy fetchPointer: 0 ofObject: specOop.
	(self isAtomicType: spec)
		ifFalse:[^FFIErrorWrongType].
	specType := self atomicTypeOf: spec.
	specType ~= atomicType ifTrue:[
		"allow for signed/unsigned conversion but nothing else"
		(atomicType > FFITypeBool and:[atomicType < FFITypeSingleFloat])
			ifFalse:[^FFIErrorCoercionFailed].
		((atomicType >> 1) = (specType >> 1))
			ifFalse:[^FFIErrorCoercionFailed]].
	^0