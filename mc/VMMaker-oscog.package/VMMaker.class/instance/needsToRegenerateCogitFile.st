generate sources
needsToRegenerateCogitFile
"check the timestamp for the relevant classes and then the timestamp for the interp.c file if it already exists. Return true if the file needs regenerating, false if not"

	| cogitClass cogitClasses tStamp fstat reference |
	cogitClass := self cogitClass.
	cogitClasses := cogitClass withAllSuperclasses copyUpThrough: Cogit.
	cogitClasses addAllLast: cogitClass ancilliaryClasses.
	tStamp := cogitClasses inject: 0 into: [:tS :cl| tS max: cl timeStamp].
	cogitClasses do:
		[:c|
		tStamp := c ancilliaryStructClasses inject: tStamp into: [:tS :cl| tS max: cl timeStamp]].

	"don't translate if the file is newer than my timeStamp"
	reference := self coreVMDirectory asFileReference / cogitClass sourceFileName.
	fstat := reference exists ifTrue: [ reference entry ] ifFalse: [nil].
	fstat ifNotNil:[ tStamp < fstat modificationTime asSeconds ifTrue:
		[^self confirm: 'The ', cogitClass printString, ' classes have not been modified since\ the source file was last generated.\Do you still want to regenerate it?' withCRs]].
	^true
