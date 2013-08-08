accessing
primitiveDlsymFn
	"return a dlsym() function address"

	| addr |
	<export: true>
	<var: #addr type: 'void*' >
	
	addr := 0.
	self cCode: '
		#ifdef RTLD_DEFAULT
			addr = (void*) &dlsym
		#endif
	'.
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1 thenPush: 
		(
		interpreterProxy positive32BitIntegerFor:  addr).
	