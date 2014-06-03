callout support
ffiCheckReturn: retSpec With: retClass
	"Make sure we can return an object of the given type"
	<inline: true>
	retClass == interpreterProxy nilObject ifFalse:[
		(interpreterProxy includesBehavior: retClass 
						ThatOf: interpreterProxy classExternalStructure)
			ifFalse:[^self ffiFail: FFIErrorBadReturn]].
	ffiRetClass := retClass.

	(interpreterProxy isWords: retSpec)
		ifFalse:[self ffiFail: FFIErrorWrongType. ^nil].
	ffiRetSpecSize := interpreterProxy slotSizeOf: retSpec.
	ffiRetSpecSize = 0 ifTrue:[self ffiFail: FFIErrorWrongType. ^nil].
	ffiRetSpec := self cCoerce: (interpreterProxy firstIndexableField: retSpec) to: 'int'.
	ffiRetHeader := interpreterProxy longAt: ffiRetSpec.
	(self isAtomicType: ffiRetHeader) ifFalse:[
		(ffiRetClass == interpreterProxy nilObject)
			ifTrue:[^self ffiFail: FFIErrorBadReturn]].
	(self ffiCan: (self cCoerce: ffiRetSpec to:'int*') Return: ffiRetSpecSize)
		ifFalse:[self ffiFail: FFIErrorBadReturn]. "cannot return this type"
	^0