callout support
ffiCalloutDoubleRetTo: procAddr in: calloutState
	<var: #procAddr type: #'void *'>
	<var: #calloutState type: #'CalloutState *'>
	| floatRet |
	<var: #floatRet type: #double>
	<returnTypeC: #double>
	<inline: true>
	calloutState floatRegisterSignature caseOf: {
			[0]-> [floatRet := self 
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(sqIntptr_t, sqIntptr_t, sqIntptr_t, sqIntptr_t)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[1]-> [floatRet := self  
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(double, sqIntptr_t, sqIntptr_t, sqIntptr_t)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[2]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(sqIntptr_t, double, sqIntptr_t, sqIntptr_t)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[3]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(double, double, sqIntptr_t, sqIntptr_t)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[4]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(sqIntptr_t, sqIntptr_t, double, sqIntptr_t)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[5]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(double, sqIntptr_t, double, sqIntptr_t)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[6]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(sqIntptr_t, double, double, sqIntptr_t)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
			[7]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(double, double, double, sqIntptr_t)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState integerRegisters at: 3)].
				
			[8]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(sqIntptr_t, sqIntptr_t, sqIntptr_t, double)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[9]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(double, sqIntptr_t, sqIntptr_t, double)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[10]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(sqIntptr_t, double, sqIntptr_t, double)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[11]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(double, double, sqIntptr_t, double)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState integerRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[12]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(sqIntptr_t, sqIntptr_t, double, double)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[13]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(double, sqIntptr_t, double, double)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState integerRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[14]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(sqIntptr_t, double, double, double)') 
					with: (calloutState integerRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].
			[15]-> [floatRet := self
					dispatchFunctionPointer: (self cCoerceSimple: procAddr to: 'double (*)(double, double, double, double)') 
					with: (calloutState floatRegisters at: 0)
					with: (calloutState floatRegisters at: 1)
					with: (calloutState floatRegisters at: 2)
					with: (calloutState floatRegisters at: 3)].} otherwise: [floatRet := 0].
	^floatRet