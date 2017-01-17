callout support
ffiCreateReturnStruct
	"Generic callout support. Create a structure return value from an external function call"
	| retOop structSize oop |
	<inline: true>
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy pop: interpreterProxy methodArgumentCount+1.
	structSize := ffiRetHeader bitAnd: FFIStructSizeMask.
	interpreterProxy pushRemappableOop: ffiRetClass.
	oop := interpreterProxy 
			instantiateClass: interpreterProxy classByteArray 
			indexableSize: structSize.
	self ffiStore: (self cCoerce: (interpreterProxy firstIndexableField: oop) to:'int') 
		Structure: structSize.
	ffiRetClass := interpreterProxy popRemappableOop.
	interpreterProxy pushRemappableOop: oop. "secure byte array"
	retOop := interpreterProxy instantiateClass: ffiRetClass indexableSize: 0.
	oop := interpreterProxy popRemappableOop.
	interpreterProxy storePointer: 0 ofObject: retOop withValue: oop.
	^interpreterProxy push: retOop.