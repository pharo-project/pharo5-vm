callout support
ffiFloatValueOf: oop
	"Support for generic callout. Return a float value that is coerced as C would do."
	| oopClass |
	<returnTypeC:'double'>
	oopClass := interpreterProxy fetchClassOf: oop.
	oopClass == interpreterProxy classFloat
		ifTrue:[^interpreterProxy floatValueOf: oop].
	"otherwise try the integer coercions and return its float value"
	^(self ffiIntegerValueOf: oop) asFloat