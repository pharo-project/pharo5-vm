plugin primitives
primLoadModule
	"Attempt to load a module of the given name.  The primitive will have a signature
	 of the form:
		<Anywhere>  primLoadModule: moduleName <String> ^<Integer>
			<primitive: 'primLoadModule' error: errorCode module: ''>
			
	Answers true if module loaded successfully, fails otherwise.
	
	We're trying to retrieve setInterpreter() function pointer from module,
	by making a call to ioLoadExternalFunctionOfLengthFromModuleOfLength() function.
	A setInterpreter() function should be exported by all valid plugins, so if we succeed with 
	getting pointer to it, it means that module is loaded successfully"
	
	| moduleName fnPtr fnName |
	
	<export: true>
	<var: #fnName declareC: 'char * fnName = "setInterpreter"'>
	<var: #fnPtr declareC: 'void * fnPtr = 0'>
	
	moduleName := self stackValue: 0.
	(objectMemory isBytes: moduleName)
		ifFalse: [^ self primitiveFailFor: PrimErrBadArgument].
	fnPtr := self
		ioLoadExternalFunction: (self oopForPointer: fnName) 
		OfLength: 14 "  'setInterpreter' size "
		FromModule: (self cCoerce: (objectMemory firstIndexableField: moduleName) to: 'sqInt')
		OfLength: (objectMemory byteSizeOf: moduleName).
		
	fnPtr = 0 ifTrue:
		[^self primitiveFailFor: PrimErrNotFound].
	self pop: 2 thenPush: true
	

