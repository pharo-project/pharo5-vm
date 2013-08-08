accessing
primitiveGetInterpreterProxy
	<export: true>

	"return a pointer to interpreterProxy struct as usqInt"
	interpreterProxy pop: 1 thenPush: 
		(interpreterProxy positive32BitIntegerFor: 
			(self cCoerce: interpreterProxy to: 'usqInt'))
	
