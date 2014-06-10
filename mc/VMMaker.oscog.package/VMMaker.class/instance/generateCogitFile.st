generate sources
generateCogitFile
	"Translate the Smalltalk description of the virtual machine into C.  If 'self doInlining' is true, small method bodies are inlined to reduce procedure call overhead.  On the PPC, this results in a factor of three speedup with only 30% increase in code size.  Subclasses can use specialised versions of CCodeGenerator and interpreterClass."

	| cg cogitClass |
	self interpreterClass needsCogit ifFalse: [^nil].
	cg := [self buildCodeGeneratorForCogit]
			on: Notification
			do: [:ex|
				ex tag == #getVMMaker
					ifTrue: [ex resume: self]
					ifFalse: [(ex respondsTo: #rearmHandlerDuring:)
								ifTrue: [ex rearmHandlerDuring: [ex pass]]
								ifFalse: [ex pass]]].
	self needsToRegenerateCogitFile ifFalse: [^nil].
	cogitClass := self cogitClass.
	cg removeUnneededBuiltins.
	cg vmClass preGenerationHook: cg.

	cg inferTypesForImplicitlyTypedVariablesAndMethods.

	cg storeCodeOnFile: (self sourceFilePathFor: cogitClass sourceFileName) doInlining: cogitClass doInlining.
	cg vmClass additionalHeadersDo:
		[:headerName :headerContents| | filePath |
		 filePath := (self coreVMDirectory / headerName) fullName.
		 (cg needToGenerateHeader: headerName file: filePath contents: headerContents) ifTrue:
			 [cg storeHeaderOnFile: filePath contents: headerContents]].
	cogitClass apiExportHeaderName ifNotNil:
		[cg storeAPIExportHeader: cogitClass apiExportHeaderName
			OnFile: (self sourceFilePathFor: cogitClass apiExportHeaderName)]