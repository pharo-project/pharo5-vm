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
	self cppIf: COGMTVM ifTrue:
	[(calloutState callFlags anyMask: FFICallFlagThreaded) ifTrue:
		[myThreadIndex := interpreterProxy disownVM: 0]].

	self registerArgsSlop + self cStackAlignment > 0 ifTrue:
		[self setsp: calloutState argVector].

	calloutState floatRegisterIndex > 0
		ifTrue:
			[self 
				load: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 0)) to: 'double *') at: 0)
				Flo: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 2)) to: 'double *') at: 0)
				a: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 4)) to: 'double *') at: 0)
				t: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 6)) to: 'double *') at: 0)
				R: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 8)) to: 'double *') at: 0)
				e: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 10)) to: 'double *') at: 0)
				g: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 12)) to: 'double *') at: 0)
				s: ((self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: 14)) to: 'double *') at: 0)
			].

	atomicType := self atomicTypeOf: calloutState ffiRetHeader.
	atomicType = FFITypeSingleFloat
		ifTrue:
			[floatRet := self 
				dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'float (*)(int, int, int, int)') 
				with: (calloutState integerRegisters at: 0)
				with: (calloutState integerRegisters at: 1)
				with: (calloutState integerRegisters at: 2)
				with: (calloutState integerRegisters at: 3)].
	 atomicType = FFITypeDoubleFloat
		ifTrue:
			[floatRet := self 
				dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(int, int, int, int)') 
				with: (calloutState integerRegisters at: 0)
				with: (calloutState integerRegisters at: 1)
				with: (calloutState integerRegisters at: 2)
				with: (calloutState integerRegisters at: 3)]
		ifFalse:
			[intRet := self 
				dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(int, int, int, int)') 
				with: (calloutState integerRegisters at: 0)
				with: (calloutState integerRegisters at: 1)
				with: (calloutState integerRegisters at: 2)
				with: (calloutState integerRegisters at: 3)].
	"undo any callee argument pops because it may confuse stack management with the alloca."
	(self isCalleePopsConvention: calloutState callFlags) ifTrue:
		[self setsp: calloutState argVector].

	self cppIf: COGMTVM ifTrue:
	[(calloutState callFlags anyMask: FFICallFlagThreaded) ifTrue:
		[interpreterProxy ownVM: myThreadIndex]].

	"Note: Order is important here since FFIFlagPointer + FFIFlagStructure is used to represent
	 'typedef void* VoidPointer' and VoidPointer must be returned as pointer *not* as struct."
	(calloutState ffiRetHeader anyMask: FFIFlagPointer) ifTrue:
		[^self ffiReturnPointer: intRet ofType: (self ffiReturnType: specOnStack) in: calloutState].

	(calloutState ffiRetHeader anyMask: FFIFlagStructure) ifTrue:
		[^self ffiReturnStruct: intRet ofType: (self ffiReturnType: specOnStack) in: calloutState].
	
	(atomicType = FFITypeSingleFloat
	 or: [atomicType = FFITypeDoubleFloat]) ifTrue:
		[^interpreterProxy methodReturnValue: (interpreterProxy floatObjectOf: floatRet)].

	^interpreterProxy methodReturnValue: (self ffiCreateIntegralResultOop: intRet
												ofAtomicType: atomicType
												in: calloutState)