translation
exportBuildInfoOrNil
	^'/* ', self idString, ' - ', self moduleName, '.c translated from class\   ' withCRs,
	  self name, ' of OSProcessPlugin version ', self versionString, ' */'