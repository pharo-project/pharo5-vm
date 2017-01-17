generate sources
generateCogitIncludeFileFor: cogitClass
	"Generate the skeletal cogit.c that includes the processor-specific cogit files."

	| code fileName file fileCode |
	code := Cogit generateCodeStringForCogitDotC.
	fileName := self coreVMDirectory fullNameFor: cogitClass sourceFileName.
	((self coreVMDirectory fileExists: cogitClass sourceFileName)
	and: [fileCode := (self class oldFileNamed: fileName) contentsOfEntireFile.
		(fileCode allButFirst: (fileCode indexOf: $#)) = (code allButFirst: (code indexOf: $#))]) ifFalse:
		[file := self class forceNewFileNamed: fileName.
		 [file nextPutAll: code] ensure:
			[file close]]