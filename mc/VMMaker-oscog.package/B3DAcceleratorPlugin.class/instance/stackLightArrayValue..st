primitive support
stackLightArrayValue: stackIndex
	"Load an Array of B3DPrimitiveLights from the given stack index"
	| oop array arraySize |
	<inline: false>
	array := interpreterProxy stackObjectValue: stackIndex.
	array = nil ifTrue:[^nil].
	array = interpreterProxy nilObject ifTrue:[^nil].
	(interpreterProxy fetchClassOf: array) = interpreterProxy classArray
		ifFalse:[^interpreterProxy primitiveFail].
	arraySize := interpreterProxy slotSizeOf: array.
	0 to: arraySize-1 do:[:i|
		oop := interpreterProxy fetchPointer: i ofObject: array.
		(interpreterProxy isIntegerObject: oop)
			ifTrue:[^interpreterProxy primitiveFail].
		((interpreterProxy isWords: oop) and:[(interpreterProxy slotSizeOf: oop) = 32])
			ifFalse:[^interpreterProxy primitiveFail].
	].
	^array