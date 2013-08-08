sound library-file in/out
fileInSoundLibraryNamed: fileName
	"File in the sound library with the given file name, and add its contents to the current sound library."

	| s newSounds |
	s := FileStream oldFileNamed: fileName.
	[ newSounds := s fileInObjectAndCode ]
		ensure: [ s close ].
	newSounds associationsDo: [:assoc | 
		self storeFiledInSound: assoc value named: assoc key].
	AbstractSound updateScorePlayers.
	Smalltalk garbageCollect.  "Large objects may have been released"
