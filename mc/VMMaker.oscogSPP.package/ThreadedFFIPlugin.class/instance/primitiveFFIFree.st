primitives
primitiveFFIFree
	"Primitive. Free the object pointed to on the external heap."
	| addr oop ptr |
	<export: true>
	<inline: false>
	<var: #ptr type: #'sqIntptr_t *'>
	oop := interpreterProxy stackObjectValue: 0.
	((interpreterProxy fetchClassOf: oop) = interpreterProxy classExternalAddress
	 and: [(interpreterProxy byteSizeOf: oop) = (self sizeof: #'sqIntptr_t')]) ifFalse:
		[^interpreterProxy primitiveFail].
	ptr := interpreterProxy firstIndexableField: oop.
	addr := ptr at: 0.
	"Don't you dare to free Squeak's memory!"
	(addr = 0
	 or: [(addr asUnsignedIntegerPtr bitAnd: (self sizeof: #'sqIntptr_t') - 1) ~= 0
	 or: [interpreterProxy isInMemory: addr]]) ifTrue:
		[^interpreterProxy primitiveFail].
	self ffiFree: addr.
	^ptr at: 0 put: 0 "cleanup"