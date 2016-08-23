callout support
ffiCalloutTo: procAddr SpecOnStack: specOnStack in: calloutState
	<var: #procAddr type: #'void *'>
	<var: #calloutState type: #'CalloutState *'>
	<var: #loadFloatRegs declareC: 'extern void loadFloatRegs(double, double, double, double, double, double, double, double)'>
	"Go out, call this guy and create the return value.  This *must* be inlined because of
	 the alloca of the outgoing stack frame in ffiCall:WithFlags:NumArgs:Args:AndTypes:"
	| myThreadIndex atomicType floatRet intRet loadFloatRegs oop |
	<var: #floatRet type: #double>
	<var: #intRet type: 'SixteenByteReturn'>
	<inline: true>
	self cCode: '' inSmalltalk: [loadFloatRegs := #used. loadFloatRegs class].
	self cppIf: COGMTVM ifTrue:
	[(calloutState callFlags anyMask: FFICallFlagThreaded) ifTrue:
		[myThreadIndex := interpreterProxy disownVM: 0]].

	self registerArgsSlop + self cStackAlignment > 0 ifTrue:
		[self setsp: calloutState argVector].

	calloutState floatRegisterIndex > 0 ifTrue:
		[self 
			load: (calloutState floatRegisters at: 0)
			Flo: (calloutState floatRegisters at: 1)
			a: (calloutState floatRegisters at: 2)
			t: (calloutState floatRegisters at: 3)
			R: (calloutState floatRegisters at: 4)
			e: (calloutState floatRegisters at: 5)
			g: (calloutState floatRegisters at: 6)
			s: (calloutState floatRegisters at: 7)].

	atomicType := self atomicTypeOf: calloutState ffiRetHeader.
	(atomicType >> 1) = (FFITypeSingleFloat >> 1)
		ifTrue:
			[atomicType = FFITypeSingleFloat
				ifTrue:
					[floatRet := self 
						dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'float (*)(long, long, long, long, long, long)') 
						with: (calloutState integerRegisters at: 0)
						with: (calloutState integerRegisters at: 1)
						with: (calloutState integerRegisters at: 2)
						with: (calloutState integerRegisters at: 3)
						with: (calloutState integerRegisters at: 4)
						with: (calloutState integerRegisters at: 5)]
				ifFalse: "atomicType = FFITypeDoubleFloat"
					[floatRet := self 
						dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(long, long, long, long, long, long)') 
						with: (calloutState integerRegisters at: 0)
						with: (calloutState integerRegisters at: 1)
						with: (calloutState integerRegisters at: 2)
						with: (calloutState integerRegisters at: 3)
						with: (calloutState integerRegisters at: 4)
						with: (calloutState integerRegisters at: 5)]]
		ifFalse:
			[intRet := self 
				dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'SixteenByteReturn (*)(long, long, long, long, long, long)') 
				with: (calloutState integerRegisters at: 0)
				with: (calloutState integerRegisters at: 1)
				with: (calloutState integerRegisters at: 2)
				with: (calloutState integerRegisters at: 3)
				with: (calloutState integerRegisters at: 4)
				with: (calloutState integerRegisters at: 5)].
	"undo any callee argument pops because it may confuse stack management with the alloca."
	(self isCalleePopsConvention: calloutState callFlags) ifTrue:
		[self setsp: calloutState argVector].

	self cppIf: COGMTVM ifTrue:
	[(calloutState callFlags anyMask: FFICallFlagThreaded) ifTrue:
		[interpreterProxy ownVM: myThreadIndex]].

	(calloutState ffiRetHeader anyMask: FFIFlagPointer+FFIFlagStructure) ifTrue:
		["Note: Order is important here since FFIFlagPointer + FFIFlagStructure is used to represent
		 'typedef void* VoidPointer' and VoidPointer must be returned as pointer *not* as struct."
		 (calloutState ffiRetHeader anyMask: FFIFlagPointer)
			ifTrue:
				[oop := self ffiReturnPointer: intRet a ofType: (self ffiReturnType: specOnStack) in: calloutState]
			ifFalse:
				[oop := self ffiReturnStruct: intRet ofType: (self ffiReturnType: specOnStack) in: calloutState].
		 ^oop].
	
	(atomicType >> 1) = (FFITypeSingleFloat >> 1)
		ifTrue:
			[oop := interpreterProxy floatObjectOf: floatRet]
		ifFalse:
			[oop := self ffiCreateIntegralResultOop: intRet a
						ofAtomicType: atomicType
						in: calloutState].
	^interpreterProxy methodReturnValue: oop