generate sources
needsToRegenerateCogitFile
	"Check the timestamp for the relevant classes and then the timestamp for the main source file (e.g. interp.c)
	 file if it already exists. Answer if the file needs regenerating."

	| cogitClass cogitClasses tStamp reference fstat |
	cogitClasses := (cogitClass := self cogitClass) withAllSuperclasses copyUpThrough: Cogit.
	cogitClasses addAllLast: (cogitClass ancilliaryClasses: self options).
	tStamp := cogitClasses inject: 0 into: [:tS :cl| tS max: cl timeStamp].

	"don't translate if the file is newer than my timeStamp"
	reference := self coreVMDirectory / cogitClass sourceFileName.
	fstat := reference exists ifTrue: [ reference entry ] ifFalse: [ nil ].	
	fstat ifNotNil: [
		tStamp < fstat modificationTime asUnixTime ifTrue:
			[^self confirm: 'The ', self configurationNameIfAny, cogitClass printString, ' classes have not been modified since\ the source file was last generated.\Do you still want to regenerate it?' withCRs]].
	^true
