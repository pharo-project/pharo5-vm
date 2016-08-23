primitives-library loading
primLoadLibrary
	"Attempt to load a library of the given name.  The primitive will have a signature
	 of the form:
		<Anywhere>  primLoadLibrary: libraryName <String> ^<Integer>
			<primitive: 'primLoadLibrary' error: errorCode module: 'IA32ABI'>"
	<export: true>
	| libraryName libraryHandle |
	<var: #libraryHandle type: #'void *'>
	libraryName := interpreterProxy stackValue: 0.
	(interpreterProxy isBytes: libraryName)
		ifFalse: [^ interpreterProxy primitiveFailFor: PrimErrBadArgument].
	libraryHandle := interpreterProxy
					ioLoadModule: (self cCoerce: (interpreterProxy firstIndexableField: libraryName) to: 'sqInt')
					OfLength: (interpreterProxy byteSizeOf: libraryName).
	libraryHandle = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNotFound].
	interpreterProxy methodReturnValue: (self positiveMachineIntegerFor: libraryHandle asUnsignedInteger)