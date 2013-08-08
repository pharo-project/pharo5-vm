callout support
ffiCheckReturn: retSpec With: retClass in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	"Make sure we can return an object of the given type"
	<inline: true>
	| ffiRetSpec |
	retClass = interpreterProxy nilObject ifFalse:[
		(interpreterProxy includesBehavior: retClass 
						ThatOf: interpreterProxy classExternalStructure)
			ifFalse:[^FFIErrorBadReturn]].

	(interpreterProxy isWords: retSpec)
		ifFalse:[^FFIErrorWrongType].
	(interpreterProxy slotSizeOf: retSpec) = 0 ifTrue:[^FFIErrorWrongType].
	ffiRetSpec := self cCoerce: (interpreterProxy firstIndexableField: retSpec) to: #int.
	calloutState ffiRetHeader: (interpreterProxy longAt: ffiRetSpec).
	(self isAtomicType: calloutState ffiRetHeader) ifFalse:[
		(retClass = interpreterProxy nilObject)
			ifTrue:[^FFIErrorBadReturn]].
	(calloutState ffiRetHeader bitAnd: (FFIFlagPointer bitOr: FFIFlagStructure)) = FFIFlagStructure ifTrue:
		[calloutState structReturnSize: (calloutState ffiRetHeader bitAnd: FFIStructSizeMask)].
	^0