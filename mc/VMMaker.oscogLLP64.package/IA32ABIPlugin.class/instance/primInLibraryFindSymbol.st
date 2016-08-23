primitives-library loading
primInLibraryFindSymbol
	"Attempt to find the address of a symbol in a loaded library.
	 The primitive can have a signature  either of the form:
		<Anywhere> primInLibrary: libraryHandle <Alien> findSymbol: symbolName <String> ^<Integer>
			<primitive: 'primInLibraryFindSymbol' error: errorCode module: 'IA32ABI'>
	 or:
		libraryHandle <Alien>  primFindSymbol: symbolName <String> ^<Integer>
			<primitive: 'primInLibraryFindSymbol' error: errorCode module: 'IA32ABI'>"
	<export: true>
	| functionName libraryProxy address |
	<var: #address type: #'void *'>
	functionName := interpreterProxy stackValue: 0.
	libraryProxy := interpreterProxy stackValue: 1.
	((self isAlien: libraryProxy)
	 and: [(interpreterProxy byteSizeOf: libraryProxy) >= (2 * interpreterProxy bytesPerOop)
	 and: [interpreterProxy isBytes: functionName]]) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	address := interpreterProxy
					ioLoadSymbol: (self cCoerce: (interpreterProxy firstIndexableField: functionName)
										to: #sqInt)
					OfLength: (interpreterProxy byteSizeOf: functionName)
					FromModule: (self longAt: libraryProxy + interpreterProxy baseHeaderSize + interpreterProxy bytesPerOop).
	(interpreterProxy failed
	 or: [address = 0]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNotFound].
	interpreterProxy methodReturnValue: (self positiveMachineIntegerFor: address asUnsignedInteger)