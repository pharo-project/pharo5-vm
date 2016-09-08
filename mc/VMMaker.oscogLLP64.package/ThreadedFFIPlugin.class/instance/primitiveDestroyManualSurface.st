primitives - surfaces
primitiveDestroyManualSurface
	"arguments: name(type, stack offset)
		surfaceID(Integer, 0)"
	| surfaceID result |
	<export: true>
	
	interpreterProxy methodArgumentCount == 1 ifFalse: [^interpreterProxy primitiveFail].
	surfaceID := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^nil].
	result := self destroyManualSurface: surfaceID.
	result = 0 ifTrue: [^interpreterProxy primitiveFail].
	^interpreterProxy pop: 1
	