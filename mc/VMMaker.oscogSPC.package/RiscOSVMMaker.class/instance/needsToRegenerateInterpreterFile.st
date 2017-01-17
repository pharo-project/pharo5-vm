initialize
needsToRegenerateInterpreterFile
	"Check the timestamp for the relevant classes and then the timestamp for the main
	 source file (e.g. interp.c) if it already exists.  Answer if the file needs regenerating."

	| classes tStamp fstat |
	classes := self interpreterClass withAllSuperclasses copyUpTo: VMClass.
	self interpreterClass objectMemoryClass ifNotNil:
		[:objectMemoryClass|
		classes addAllLast: (objectMemoryClass withAllSuperclasses copyUpTo: VMClass)].
	classes copy do:
		[:class| classes addAllLast: (class ancilliaryClasses: self options)].
	tStamp := classes inject: 0 into: [:tS :cl| tS max: cl timeStamp].

	"don't translate if the file is newer than my timeStamp"
	"RiscOS keeps the interp file in a 'c' subdirectory of coreVMDirectory"
	(self coreVMDirectory directoryExists: 'c') ifFalse:[^true].

	fstat := (self coreVMDirectory directoryNamed: 'c') entryAt: self interpreterFilename ifAbsent:[nil].
	fstat ifNotNil:[tStamp < fstat modificationTime ifTrue:[^false]].
	^true
