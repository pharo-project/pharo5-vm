accessing
interpreterVersion
	| memoryManagerVersion |
	memoryManagerVersion := (self options at: #ObjectMemory ifAbsent: [ #ObjectMemory ]) asClass memoryManagerVersion.
	^ self vmClass interpreterVersion, '[', memoryManagerVersion,']'