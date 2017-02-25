callout support
ffiCreateReturnPointer: retVal
	"Generic callout support. Create a pointer return value from an external function call"
	| atomicType retOop oop ptr classOop |
	<var: #ptr type:'int *'>
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy pop: interpreterProxy methodArgumentCount+1.
	(ffiRetClass == interpreterProxy nilObject) ifTrue:[
		"Create ExternalData upon return"
		atomicType := self atomicTypeOf: ffiRetHeader.
		(atomicType >> 1) = (FFITypeSignedChar >> 1) ifTrue:["String return"
			^self ffiReturnCStringFrom: retVal].
		"generate external data"
		interpreterProxy pushRemappableOop: ffiRetOop.
		oop := interpreterProxy 
				instantiateClass: interpreterProxy classExternalAddress 
				indexableSize: 4.
		ptr := interpreterProxy firstIndexableField: oop.
		ptr at: 0 put: retVal.
		interpreterProxy pushRemappableOop: oop. "preserve for gc"
		retOop := interpreterProxy 
				instantiateClass: interpreterProxy classExternalData 
				indexableSize: 0.
		oop := interpreterProxy popRemappableOop. "external address"
		interpreterProxy storePointer: 0 ofObject: retOop withValue: oop.
		oop := interpreterProxy popRemappableOop. "return type"
		interpreterProxy storePointer: 1 ofObject: retOop withValue: oop.
		^interpreterProxy push: retOop.
	].
	"non-atomic pointer return"
	interpreterProxy pushRemappableOop: ffiRetClass. "preserve for gc"
	(ffiRetHeader anyMask: FFIFlagStructure)
		ifTrue:[classOop := interpreterProxy classByteArray]
		ifFalse:[classOop := interpreterProxy classExternalAddress].
	oop := interpreterProxy 
			instantiateClass: classOop
			indexableSize: 4.
	ptr := interpreterProxy firstIndexableField: oop.
	ptr at: 0 put: retVal.
	ffiRetClass := interpreterProxy popRemappableOop. "return class"
	interpreterProxy pushRemappableOop: oop. "preserve for gc"
	retOop := interpreterProxy instantiateClass: ffiRetClass indexableSize: 0.
	oop := interpreterProxy popRemappableOop. "external address"
	interpreterProxy storePointer: 0 ofObject: retOop withValue: oop.
	^interpreterProxy push: retOop.