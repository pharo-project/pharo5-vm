callout support
ffiCalloutTo: procAddr SpecOnStack: specOnStack in: calloutState
	<var: #procAddr type: #'void *'>
	<var: #calloutState type: #'CalloutState *'>
	"Go out, call this guy and create the return value.  This *must* be inlined because of
	 the alloca of the outgoing stack frame in ffiCall:WithFlags:NumArgs:Args:AndTypes:"
	| myThreadIndex atomicType floatRet intRet |
	<var: #floatRet type: #double>
	<var: #intRet type: #usqLong>
	<inline: true>
	self maybeDisownVM: calloutState threadIndexInto: [:threadIndex| myThreadIndex := threadIndex].

	(self allocaLiesSoSetSpBeforeCall or: [self mustAlignStack]) ifTrue:
		[self setsp: calloutState argVector].

	atomicType := self atomicTypeOf: calloutState ffiRetHeader.
	(atomicType >> 1) = (FFITypeSingleFloat >> 1) ifTrue:
		[floatRet := self dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)()').

		 "undo any callee argument pops because it may confuse stack management with the alloca."
		 (self isCalleePopsConvention: calloutState callFlags) ifTrue:
			[self setsp: calloutState argVector].
		 self maybeOwnVM: calloutState threadIndex: myThreadIndex.

		 ^interpreterProxy floatObjectOf: floatRet].

	intRet := self dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)()').

	"undo any callee argument pops because it may confuse stack management with the alloca."
	(self isCalleePopsConvention: calloutState callFlags) ifTrue:
		[self setsp: calloutState argVector].
	self maybeOwnVM: calloutState threadIndex: myThreadIndex.

	(calloutState ffiRetHeader anyMask: FFIFlagPointer+FFIFlagStructure) ifTrue:
		["Note: Order is important here since FFIFlagPointer + FFIFlagStructure is used to represent
		 'typedef void* VoidPointer' and VoidPointer must be returned as pointer *not* as struct."
		 (calloutState ffiRetHeader anyMask: FFIFlagPointer) ifTrue:
			[^self ffiReturnPointer: intRet ofType: (self ffiReturnType: specOnStack) in: calloutState].
		 ^self ffiReturnStruct: intRet ofType: (self ffiReturnType: specOnStack) in: calloutState].
	
	^self ffiCreateIntegralResultOop: intRet ofAtomicType: atomicType in: calloutState