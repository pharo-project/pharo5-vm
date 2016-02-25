callout support
ffiCheckReturn: retSpec With: retClass in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	"Make sure we can return an object of the given type"
	<inline: true>
	retClass = interpreterProxy nilObject ifFalse:
		[(interpreterProxy
				includesBehavior: retClass 
				ThatOf: interpreterProxy classExternalStructure) ifFalse:
			[^FFIErrorBadReturn]].

	((interpreterProxy isWords: retSpec)
	 and: [(interpreterProxy slotSizeOf: retSpec) > 0]) ifFalse:
		[^FFIErrorWrongType].

	calloutState ffiRetHeader: (interpreterProxy fetchLong32: 0 ofObject: retSpec).
	(self isAtomicType: calloutState ffiRetHeader) ifFalse:
		[retClass = interpreterProxy nilObject ifTrue:
			[^FFIErrorBadReturn]].
	(calloutState ffiRetHeader bitAnd: (FFIFlagPointer bitOr: FFIFlagStructure)) = FFIFlagStructure ifTrue:
		[calloutState structReturnSize: (calloutState ffiRetHeader bitAnd: FFIStructSizeMask)].
	^0