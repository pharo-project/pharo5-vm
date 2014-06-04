callout support
ffiIntegerValueOf: oop
	"Support for generic callout. Return an integer value that is coerced as C would do."
	| oopClass |
	<inline: true>
	(interpreterProxy isIntegerObject: oop) ifTrue:[^interpreterProxy integerValueOf: oop].
	oop == interpreterProxy nilObject ifTrue:[^0]. "@@: should we really allow this????"
	oop == interpreterProxy falseObject ifTrue:[^0].
	oop == interpreterProxy trueObject ifTrue:[^1].
	oopClass := interpreterProxy fetchClassOf: oop.
	oopClass == interpreterProxy classFloat
		ifTrue:[^(interpreterProxy floatValueOf: oop) asInteger].
	oopClass == interpreterProxy classCharacter
		ifTrue:[^interpreterProxy characterValueOf: oop].
	oopClass == interpreterProxy classLargePositiveInteger
		ifTrue:[^interpreterProxy positive32BitValueOf: oop].
	^interpreterProxy signed32BitValueOf: oop "<- will fail if not integer"