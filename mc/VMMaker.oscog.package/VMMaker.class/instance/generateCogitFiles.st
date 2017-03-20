generate sources
generateCogitFiles
	"Translate the Smalltalk description of the virtual machine's JITs into C."
	| cogitClass cg |
	(cogitClass := self interpreterClass cogitClass) ifNil: [^nil].
	self generateCogitIncludeFileFor: cogitClass.
	cogitClass translateableInstructionSubclassesAndInstalledOptionsDo:
		[:compilerClass|
		cg := self generateCogitFileFor: cogitClass].
	cg vmClass additionalHeadersDo:
		[:headerName :headerContents| | filePath |
		 filePath := self coreVMDirectory fullNameFor: headerName.
		 (cg needToGenerateHeader: headerName file: filePath contents: headerContents) ifTrue:
			 [cg storeHeaderOnFile: filePath contents: headerContents]].
	cogitClass apiExportHeaderName ifNotNil:
		[cg storeAPIExportHeader: cogitClass apiExportHeaderName
			OnFile: (self sourceFilePathFor: cogitClass apiExportHeaderName)]