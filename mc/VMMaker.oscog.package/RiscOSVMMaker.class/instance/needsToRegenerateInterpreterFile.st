initialize
needsToRegenerateInterpreterFile
"check the timestamp for the relevant classes and then the timestamp for the interp.c file if it already exists. Return true if the file needs regenerating, false if not"

	| tStamp fstat reference |

	tStamp := (self interpreterClass withAllSuperclasses copyUpTo: ObjectMemory superclass),
				(self interpreterClass ancilliaryClasses: self options)
					inject: 0 into: [:tS :cl| tS max: cl timeStamp].

	"don't translate if the file is newer than my timeStamp"
	"RiscOS keeps the interp file in a 'c' subdirectory of coreVMDirectory"
	(self coreVMDirectory / 'c') exists ifFalse:[ ^ true ].

	reference := self coreVMDirectory asFileReference / 'c' / self interpreterFilename.
	fstat := reference exists ifTrue: [ reference entry ] ifFalse: [nil].
	fstat ifNotNil:[tStamp < fstat modificationTime ifTrue:[^false]].
	^true
