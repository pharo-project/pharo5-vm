target directories
sourceDirectoryName: aString
	"Sanity check really ought to be added, This is the root directory for where the sources will be WRITTEN"

	sourceDirName := aString.
	aString asFileReference ensureCreateDirectory.
	self changed: #sourceDirectory.
	^ true