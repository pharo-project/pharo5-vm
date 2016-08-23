primitive support
stackLightArrayValue: stackIndex
	"Load an Array of B3DPrimitiveLights from the given stack index"
	| oop array arraySize |
	<inline: false>
	array := interpreterProxy stackObjectValue: stackIndex.
	array = nil ifTrue:[^nil]. "really??"
	array = interpreterProxy nilObject ifTrue:[^nil].
	(interpreterProxy isArray: array)
		ifFalse:[^interpreterProxy primitiveFail].
	arraySize := interpreterProxy slotSizeOf: array.
	0 to: arraySize-1 do:[:i|
		oop := interpreterProxy fetchPointer: i ofObject: array.
		((interpreterProxy isWords: oop) and:[(interpreterProxy slotSizeOf: oop) = 32])
			ifFalse:[^interpreterProxy primitiveFail].
	].
	^array