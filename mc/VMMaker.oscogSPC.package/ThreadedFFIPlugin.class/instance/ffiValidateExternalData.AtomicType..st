callout support
ffiValidateExternalData: oop AtomicType: atomicType
	"Validate if the given oop (an instance of ExternalData) can be passed as a pointer to the given atomic type."
	| ptrType specOop spec specType |
	<inline: true>
	ptrType := interpreterProxy fetchPointer: 1 ofObject: oop.
	((interpreterProxy isPointers: ptrType)
	and: [(interpreterProxy slotSizeOf: ptrType) >= 2]) ifFalse:
		[^FFIErrorWrongType].
	specOop := interpreterProxy fetchPointer: 0 ofObject: ptrType.
	((interpreterProxy isWords: specOop)
	and: [(interpreterProxy slotSizeOf: specOop) > 0]) ifFalse:
		[^FFIErrorWrongType].
	spec := interpreterProxy fetchPointer: 0 ofObject: specOop.
	(self isAtomicType: spec) ifFalse:
		[^FFIErrorWrongType].
	specType := self atomicTypeOf: spec.
	specType ~= atomicType ifTrue:
		"Allow for signed/unsigned conversion but nothing else.
		 See FFIConstants class>>#initializeTypeConstants"
		[(atomicType >= FFITypeUnsignedByte
		  and: [atomicType <= FFITypeSignedChar
		  and: [(atomicType >> 1) = (specType >> 1)]]) ifFalse:
			[^FFIErrorCoercionFailed]].
	^0