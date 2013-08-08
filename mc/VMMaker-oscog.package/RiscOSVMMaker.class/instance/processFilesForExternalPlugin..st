processing external files
processFilesForExternalPlugin: plugin 
	"After the plugin has created any files we need to move them around a little to suit RiscOS; any *.c file must be moved to a 'c' subdirectory, likwise any h file"
	| files fd |
	files := (fd := self externalPluginsDirectoryFor: plugin) fileNamesMatching:'*.c'.
	files notEmpty ifTrue:[fd assureExistenceOfPath: 'c'.
		files do:[:fn|
			self copyFileNamed: (fd fullNameFor: fn) to: ((fd directoryNamed:'c') fullNameFor:(fn allButLast: 2)).
			fd deleteFileNamed: fn]].

	files := (self externalPluginsDirectoryFor: plugin) fileNamesMatching:'*.h'.
	files notEmpty ifTrue:[fd assureExistenceOfPath: 'h'.
		files do:[:fn|
			self copyFileNamed: (fd fullNameFor: fn) to: ((fd directoryNamed:'h') fullNameFor:(fn allButLast: 2)).
			fd deleteFileNamed: fn]].
	super processFilesForExternalPlugin: plugin
