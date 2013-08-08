callout support
ffiReturnPointer: retVal ofType: retType in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	<var: #retVal type: #usqLong>
	"Generic callout support. Create a pointer return value from an external function call"
	| retClass atomicType retOop oop ptr classOop |
	<var: #ptr type: #'sqInt *'>
	retClass := interpreterProxy fetchPointer: 1 ofObject: retType.
	retClass = interpreterProxy nilObject ifTrue:
		["Create ExternalData upon return"
		atomicType := self atomicTypeOf: calloutState ffiRetHeader.
		(atomicType >> 1) = (FFITypeSignedChar >> 1) ifTrue: "String return"
			[^self ffiReturnCStringFrom: (self cCoerceSimple: retVal to: #usqInt)].
		"generate external data"
		interpreterProxy pushRemappableOop: retType.
		oop := interpreterProxy 
				instantiateClass: interpreterProxy classExternalAddress 
				indexableSize: 4.
		ptr := interpreterProxy firstIndexableField: oop.
		ptr at: 0 put: (self cCoerceSimple: retVal to: #sqInt).
		interpreterProxy pushRemappableOop: oop. "preserve for gc"
		retOop := interpreterProxy 
				instantiateClass: interpreterProxy classExternalData 
				indexableSize: 0.
		oop := interpreterProxy popRemappableOop. "external address"
		interpreterProxy storePointer: 0 ofObject: retOop withValue: oop.
		oop := interpreterProxy popRemappableOop. "return type"
		interpreterProxy storePointer: 1 ofObject: retOop withValue: oop.
		^interpreterProxy methodReturnValue: retOop].
	"non-atomic pointer return"
	interpreterProxy pushRemappableOop: retClass. "preserve for gc"
	classOop := (calloutState ffiRetHeader anyMask: FFIFlagStructure)
					ifTrue:[interpreterProxy classByteArray]
					ifFalse:[interpreterProxy classExternalAddress].
	oop := interpreterProxy 
			instantiateClass: classOop
			indexableSize: 4.
	ptr := interpreterProxy firstIndexableField: oop.
	ptr at: 0 put: (self cCoerceSimple: retVal to: #sqInt).
	retClass := interpreterProxy popRemappableOop. "return class"
	interpreterProxy pushRemappableOop: oop. "preserve for gc"
	retOop := interpreterProxy instantiateClass: retClass indexableSize: 0.
	oop := interpreterProxy popRemappableOop. "external address"
	interpreterProxy storePointer: 0 ofObject: retOop withValue: oop.
	^interpreterProxy methodReturnValue: retOop