generate sources
generateCogitFiles
	"Translate the Smalltalk description of the virtual machine into C.  If 'self doInlining' is true, small method bodies are inlined to reduce procedure call overhead.  On the PPC, this results in a factor of three speedup with only 30% increase in code size.  Subclasses can use specialised versions of CCodeGenerator and interpreterClass."

	| cogitClass cg |
	(cogitClass := self interpreterClass cogitClass) ifNil: [^nil].
	self generateCogitIncludeFileFor: cogitClass.
	CogAbstractInstruction translateableSubclasses do:
		[:compilerClass|
		optionsDictionary at: #ISA put: compilerClass ISA.
		cg := self generateCogitFileFor: cogitClass].
	cg vmClass additionalHeadersDo:
		[:headerName :headerContents| | filePath |
		 filePath := self coreVMDirectory fullNameFor: headerName.
		 (cg needToGenerateHeader: headerName file: filePath contents: headerContents) ifTrue:
			 [cg storeHeaderOnFile: filePath contents: headerContents]].
	cogitClass apiExportHeaderName ifNotNil:
		[cg storeAPIExportHeader: cogitClass apiExportHeaderName
			OnFile: (self sourceFilePathFor: cogitClass apiExportHeaderName)]