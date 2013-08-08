primitive support
stackMaterialValue: stackIndex
	"Load a B3DMaterial from the given stack index"
	| oop |
	<inline: false>
	<returnTypeC:'void *'>
	oop := interpreterProxy stackObjectValue: stackIndex.
	oop = nil ifTrue:[^nil].
	oop = interpreterProxy nilObject ifTrue:[^nil].
	((interpreterProxy isWords: oop) and:[(interpreterProxy slotSizeOf: oop) =  17])
		ifTrue:[^interpreterProxy firstIndexableField: oop].
	^nil