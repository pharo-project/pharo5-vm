initialize
needsToRegenerateInterpreterFile
"check the timestamp for the relevant classes and then the timestamp for the interp.c file if it already exists. Return true if the file needs regenerating, false if not"

	| classes tStamp fstat reference |
	classes := self interpreterClass withAllSuperclasses copyUpTo: VMClass.
	self interpreterClass objectMemoryClass ifNotNil:
		[:objectMemoryClass|
		classes addAllLast: (objectMemoryClass  withAllSuperclasses copyUpTo: VMClass)].
	classes copy do:
		[:class| classes addAllLast: class ancilliaryClasses].
	classes copy do:
		[:class| classes addAllLast: class ancilliaryStructClasses].
	tStamp := classes inject: 0 into: [:tS :cl| tS max: cl timeStamp].

	"don't translate if the file is newer than my timeStamp"
	reference := self coreVMDirectory asFileReference / self interpreterFilename.
	fstat := reference exists ifTrue: [ reference entry ] ifFalse: [nil].
	fstat ifNotNil:[ tStamp < fstat modificationTime asSeconds ifTrue:
		[^self confirm: 'The interpreter classes have not been modified since\ the interpreter file was last generated.\Do you still want to regenerate their source file?' withCRs]].
	^true
