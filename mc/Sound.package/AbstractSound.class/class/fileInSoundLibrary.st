sound library-file in/out
fileInSoundLibrary
	"Prompt the user for a file name and the file in the sound library with that name."
	"AbstractSound fileInSoundLibrary"

	| fileName |
	fileName := UIManager default request: 'Sound library file name?'.
	fileName isEmptyOrNil ifTrue: [^ self].
	(fileName endsWith: '.sounds') ifFalse: [fileName := fileName, '.sounds'].
	self fileInSoundLibraryNamed: fileName.
