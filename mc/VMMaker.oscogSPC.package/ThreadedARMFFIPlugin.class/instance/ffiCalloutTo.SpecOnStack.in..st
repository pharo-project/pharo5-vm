callout support
ffiCalloutTo: procAddr SpecOnStack: specOnStack in: calloutState
	<var: #procAddr type: #'void *'>
	<var: #calloutState type: #'CalloutState *'>
	<var: #loadFloatRegs declareC: 'extern void loadFloatRegs(double, double, double, double, double, double, double, double)'>
	"Go out, call this guy and create the return value.  This *must* be inlined because of
	 the alloca of the outgoing stack frame in ffiCall:WithFlags:NumArgs:Args:AndTypes:"
	| myThreadIndex atomicType floatRet intRet loadFloatRegs |
	<var: #floatRet type: #double>
	<var: #intRet type: #usqLong>
	<inline: true>
	self cCode: '' inSmalltalk: [loadFloatRegs := #used. loadFloatRegs class].
	self maybeDisownVM: calloutState threadIndexInto: [:threadIndex| myThreadIndex := threadIndex].

	calloutState floatRegisterIndex > 0 ifTrue:
		[self 
			load: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 0)) to: 'double *') at: 0)
			Flo: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 2)) to: 'double *') at: 0)
			a: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 4)) to: 'double *') at: 0)
			t: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 6)) to: 'double *') at: 0)
			R: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 8)) to: 'double *') at: 0)
			e: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 10)) to: 'double *') at: 0)
			g: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 12)) to: 'double *') at: 0)
			s: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 14)) to: 'double *') at: 0)].

	(self allocaLiesSoSetSpBeforeCall or: [self mustAlignStack]) ifTrue:
		[self setsp: calloutState argVector].

	atomicType := self atomicTypeOf: calloutState ffiRetHeader.
	(atomicType >> 1) = (FFITypeSingleFloat >> 1) ifTrue:
		[atomicType = FFITypeSingleFloat
			ifTrue:
				[floatRet := self 
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'float (*)(sqIntptr_t, sqIntptr_t, sqIntptr_t, sqIntptr_t)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState integerRegisters at: 3)]
			ifFalse: "atomicType = FFITypeDoubleFloat"
				[floatRet := self 
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(sqIntptr_t, sqIntptr_t, sqIntptr_t, sqIntptr_t)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].

		 "undo any callee argument pops because it may confuse stack management with the alloca."
		 (self isCalleePopsConvention: calloutState callFlags) ifTrue:
			[self setsp: calloutState argVector].
		 self maybeOwnVM: calloutState threadIndex: myThreadIndex.

		 ^interpreterProxy floatObjectOf: floatRet].

	intRet := self 
				dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqIntptr_t (*)(sqIntptr_t, sqIntptr_t, sqIntptr_t, sqIntptr_t)') 
				with: (calloutState integerRegisters at: 0)
				with: (calloutState integerRegisters at: 1)
				with: (calloutState integerRegisters at: 2)
				with: (calloutState integerRegisters at: 3).

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