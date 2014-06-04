target directories
sourceDirectory
	| fd |
	fd := (sourceDirName ifNil: [self class sourceDirName, self vmBitnessString]) asFileReference.
	fd ensureCreateDirectory.
	^ fd