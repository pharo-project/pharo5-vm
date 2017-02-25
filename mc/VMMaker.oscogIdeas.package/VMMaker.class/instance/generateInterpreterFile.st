generate sources
generateInterpreterFile
	"Translate the Smalltalk description of the virtual machine into C.  If 'self doInlining' is true, small method bodies are inlined to reduce procedure call overhead.  On the PPC, this results in a factor of three speedup with only 30% increase in code size.  Subclasses can use specialised versions of CCodeGenerator and interpreterClass."

	| cg vmHeaderContents |
	cg := [self buildCodeGeneratorForInterpreter]
			on: Notification
			do: [:ex|
				ex tag == #getVMMaker
					ifTrue: [ex resume: self]
					ifFalse: [(ex respondsTo: #rearmHandlerDuring:)
								ifTrue: [ex rearmHandlerDuring: [ex pass]]
								ifFalse: [ex pass]]].
	self reinitializeWordSizeFrom: cg.
	self needsToRegenerateInterpreterFile ifFalse: [^nil].

	cg inferTypesForImplicitlyTypedVariablesAndMethods.

	self interpreterClass preGenerationHook: cg.
	vmHeaderContents := cg vmHeaderContentsWithBytesPerWord: self wordSize.
	(cg needToGenerateHeader: self interpreterHeaderName file: self interpreterHeaderPath contents: vmHeaderContents) ifTrue:
		[cg storeHeaderOnFile: self interpreterHeaderPath contents: vmHeaderContents].
	cg storeCodeOnFile: (self sourceFilePathFor: self interpreterClass sourceFileName) doInlining: self doInlining.
	self interpreterClass additionalHeadersDo:
		[:headerName :headerContents| | filePath |
		 filePath := self coreVMDirectory fullNameFor: headerName.
		 (cg needToGenerateHeader: headerName file: filePath contents: headerContents) ifTrue:
			 [cg storeHeaderOnFile: filePath contents: headerContents]].
	self interpreterClass apiExportHeaderName ifNotNil:
		[cg storeAPIExportHeader: self interpreterClass apiExportHeaderName
			OnFile: (self sourceFilePathFor: self interpreterClass apiExportHeaderName)].
	self gnuifyInterpreterFile