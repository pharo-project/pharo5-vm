callout support
ffiCalloutIntRetTo: procAddr in: calloutState
	<var: #procAddr type: #'void *'>
	<var: #calloutState type: #'CalloutState *'>
	| intRet |
	<var: #intRet type: #usqLong>
	<returnTypeC: #usqLong>
	<inline: true>
	calloutState floatRegisterSignature caseOf: {
			[0]-> [intRet := self 
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(sqIntptr_t, sqIntptr_t, sqIntptr_t, sqIntptr_t)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[1]-> [intRet := self  
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(double, sqIntptr_t, sqIntptr_t, sqIntptr_t)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[2]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(sqIntptr_t, double, sqIntptr_t, sqIntptr_t)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[3]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(double, double, sqIntptr_t, sqIntptr_t)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[4]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(sqIntptr_t, sqIntptr_t, double, sqIntptr_t)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[5]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(double, sqIntptr_t, double, sqIntptr_t)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[6]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(sqIntptr_t, double, double, sqIntptr_t)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[7]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(double, double, double, sqIntptr_t)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
				
			[8]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(sqIntptr_t, sqIntptr_t, sqIntptr_t, double)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[9]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(double, sqIntptr_t, sqIntptr_t, double)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[10]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(sqIntptr_t, double, sqIntptr_t, double)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[11]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(double, double, sqIntptr_t, double)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[12]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(sqIntptr_t, sqIntptr_t, double, double)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[13]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(double, sqIntptr_t, double, double)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[14]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(sqIntptr_t, double, double, double)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[15]-> [intRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'usqLong (*)(double, double, double, double)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].} otherwise: [intRet := 0].
	^intRet