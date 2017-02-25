translation
isSameLevelObjectAccessor: selector
	"For accessor depth calculation, answer if selector doesn't traverse into an object, merely deriving a pointer from it."
	^#(arrayValueOf: firstFixedField: firstIndexableField:) includes: selector