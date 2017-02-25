target directories
sourceDirectory
	| fd |
	fd := FileDirectory default directoryNamed: (sourceDirName
		ifNil: [self class sourceDirName, self vmBitnessString]).
	fd assureExistence.
	^ fd