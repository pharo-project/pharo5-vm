primitives - surfaces
primitiveSetManualSurfacePointer
	"Create a 'manual surface' data-structure.  See the ExternalForm class in the FFI package for example usage."
	"arguments: name(type, stack offset)
		surfaceID(Integer, 1)
		ptr(uint32, 0)"
	| surfaceID ptr result |
	<export: true>
	<var: #ptr type: #'unsigned int'>
	
	interpreterProxy methodArgumentCount == 2 ifFalse: [^interpreterProxy primitiveFail].
	surfaceID := interpreterProxy stackIntegerValue: 1.
	ptr := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed ifTrue: [^nil].

	self touch: surfaceID; touch: ptr.
	
	result := self cCode: 'setManualSurfacePointer(surfaceID, (void*)ptr)'.
	result = 0 ifTrue: [^interpreterProxy primitiveFail].
	^interpreterProxy pop: 2
	