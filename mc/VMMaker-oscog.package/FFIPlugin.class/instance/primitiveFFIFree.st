primitives
primitiveFFIFree
	"Primitive. Free the object pointed to on the external heap."
	| addr oop ptr |
	<export: true>
	<inline: false>
	<var: #ptr type:'int *'>
	oop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy fetchClassOf: oop) = (interpreterProxy classExternalAddress)
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy byteSizeOf: oop) = 4
		ifFalse:[^interpreterProxy primitiveFail].
	ptr := interpreterProxy firstIndexableField: oop.
	addr := ptr at: 0.
	"Don't you dare to free Squeak's memory!"
	(addr = 0 or:[interpreterProxy isInMemory: addr])
		ifTrue:[^interpreterProxy primitiveFail].
	self ffiFree: addr.
	^ptr at: 0 put: 0. "cleanup"
