generate sources
needsToRegenerateCogitFile
	"Check the timestamp for the relevant classes and then the timestamp for the main source file (e.g. interp.c)
	 file if it already exists. Answer if the file needs regenerating."

	| cogitClass cogitClasses tStamp files |
	cogitClasses := (cogitClass := self interpreterClass cogitClass) withAllSuperclasses copyUpThrough: Cogit.
	cogitClasses addAllLast: (cogitClass ancilliaryClasses: self options).
	tStamp := cogitClasses inject: 0 into: [:tS :cl| tS max: cl timeStamp].

	"don't translate if the file(s) is newer than my timeStamp"
	files := (self coreVMDirectory fileNamesMatching: cogitClass activeCompilerClass moduleName, '*.c').
	files isEmpty ifTrue:
		[^true].
	(files allSatisfy:
		[:fileName|
		(self coreVMDirectory entryAt: fileName ifAbsent: [nil])
			ifNil: [false]
			ifNotNil:
				[:fstat| | mTime |
				mTime := fstat modificationTime.
				mTime isInteger ifFalse: [mTime := mTime asSeconds].
				tStamp > mTime]]) ifTrue:
		[^self confirm: ('The ', self configurationNameIfAny, cogitClass printString,
			', ', cogitClass activeCompilerClass, '\classes have not been modified since the ',
			cogitClass processorSpecificSourceFileName,
			' source file\was last generated.  Do you still want to regenerate it?') withCRs].
	^true