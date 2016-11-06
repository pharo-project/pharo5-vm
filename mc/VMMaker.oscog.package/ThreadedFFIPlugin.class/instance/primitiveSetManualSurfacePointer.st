primitives - surfaces
primitiveSetManualSurfacePointer
	"Create a 'manual surface' data-structure.  See the ExternalForm class in the FFI package for example usage."
	"arguments: name(type, stack offset)
		surfaceID(Integer, 1)
		ptr(uint32/uint64, 0)"
	| surfaceID ptr result |
	<export: true>
	<var: #ptr type: #'usqIntptr_t'>
	
	interpreterProxy methodArgumentCount = 2 ifFalse: [^interpreterProxy primitiveFail].
	surfaceID := interpreterProxy stackIntegerValue: 1.
	ptr := interpreterProxy positiveMachineIntegerValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed ifTrue: [^nil].

	self touch: surfaceID; touch: ptr.
	
	result := self setManualSurface: surfaceID Pointer: ptr asVoidPointer.
	result = 0 ifTrue: [^interpreterProxy primitiveFail].
	^interpreterProxy pop: 2
	