printing
printAsAssemblerOn: aStream
	aStream nextPut: $(; print: self class; nextPutAll: ' new initializeForAssembly'.

	self printAccessorsForAssemblyOn: aStream.
	self printLiteralsForAssemblyOn: aStream.
	self printInstructionsForAssemblyOn: aStream.

	aStream crtab; nextPutAll: #yourself; nextPut: $)