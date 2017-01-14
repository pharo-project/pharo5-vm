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
			[retOop := self ffiReturnCStringFrom: (self cCoerceSimple: retVal to: #usqInt).
			 ^retOop].
		"generate external data"
		self remapOop: retType in:
			[oop := interpreterProxy
						instantiateClass: interpreterProxy classExternalAddress 
						indexableSize: BytesPerWord.
			ptr := interpreterProxy firstIndexableField: oop.
			ptr at: 0 put: (self cCoerceSimple: retVal to: #sqInt).
			self remapOop: oop in:
				[retOop := interpreterProxy 
								instantiateClass: interpreterProxy classExternalData 
								indexableSize: 0].
			interpreterProxy storePointer: 0 ofObject: retOop withValue: oop].
		interpreterProxy storePointer: 1 ofObject: retOop withValue: retType.
		^retOop].
	"non-atomic pointer return"
	classOop := (calloutState ffiRetHeader anyMask: FFIFlagStructure)
					ifTrue:[interpreterProxy classByteArray]
					ifFalse:[interpreterProxy classExternalAddress].
	self remapOop: retClass in:
		[oop := interpreterProxy 
					instantiateClass: classOop
					indexableSize: BytesPerWord].
	ptr := interpreterProxy firstIndexableField: oop.
	ptr at: 0 put: (self cCoerceSimple: retVal to: #sqInt).
	self remapOop: oop in:
		[retOop := interpreterProxy instantiateClass: retClass indexableSize: 0].
	interpreterProxy storePointer: 0 ofObject: retOop withValue: oop.
	^retOop