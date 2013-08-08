accessing
primitiveDlopenFn
	| addr |
	<export: true>
	<var: #addr type: 'void*' >
	
	addr := 0.
	self cCode: '
		#ifdef RTLD_DEFAULT
			addr = (void*) &dlopen
		#endif
	'.
	"return a dlopen() function address"
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1 thenPush: 
		(
		interpreterProxy positive32BitIntegerFor:  addr).
	