accessing
primitiveLastNativeCodeError
	<export: true>

	"return a primitive failure code, set during last use of #primitiveNativeCall"
	interpreterProxy pop: 1 thenPush: 
		(interpreterProxy signed32BitIntegerFor: lastError)
	
