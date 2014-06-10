primitives
primitiveFFIAllocate
	"Primitive. Allocate an object on the external heap."
	| byteSize addr oop ptr |
	<export: true>
	<inline: false>
	<var: #ptr type:'int *'>
	byteSize := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	addr := self ffiAlloc: byteSize.
	addr = 0 ifTrue:[^interpreterProxy primitiveFail].
	oop := interpreterProxy 
			instantiateClass: interpreterProxy classExternalAddress 
			indexableSize: 4.
	ptr := interpreterProxy firstIndexableField: oop.
	ptr at: 0 put: addr.
	interpreterProxy pop: 2.
	^interpreterProxy push: oop.
