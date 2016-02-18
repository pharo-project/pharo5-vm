initialize
needsToRegenerateInterpreterFile
	"Check the timestamp for the relevant classes and then the timestamp for the main
	 source file (e.g. interp.c) if it already exists.  Answer if the file needs regenerating."

	| classes tStamp |
	classes := self interpreterClass withAllSuperclasses copyUpTo: VMClass.
	self interpreterClass objectMemoryClass ifNotNil:
		[:objectMemoryClass|
		classes addAllLast: (objectMemoryClass withAllSuperclasses copyUpTo: VMClass)].
	classes copy do:
		[:class| classes addAllLast: (class ancilliaryClasses: self options)].
	tStamp := classes inject: 0 into: [:tS :cl| tS max: cl timeStamp].

	"don't translate if the file is newer than my timeStamp"
	(self coreVMDirectory entryAt: self interpreterFilename ifAbsent: [nil]) ifNotNil:
		[:fstat| | mTime |
		mTime := fstat modificationTime.
		mTime isInteger ifFalse: [mTime := mTime asSeconds].
		tStamp < mTime ifTrue:
			[^self confirm: 'The ', self configurationNameIfAny, 'interpreter classes have not been modified since\ the interpreter file was last generated.\Do you still want to regenerate the source file?' withCRs]].
	^true
