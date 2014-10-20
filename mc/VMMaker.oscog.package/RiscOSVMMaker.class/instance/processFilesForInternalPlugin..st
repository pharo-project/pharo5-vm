processing external files
processFilesForInternalPlugin: plugin 
	"After the plugin has created any files we need to move them around a little to suit RiscOS; any *.c file must be moved to a 'c' subdirectory, likwise any h file"
	| files fd |
	files := (fd := self internalPluginsDirectoryFor: plugin) fileNamesMatching:'*.c'.
	files notEmpty ifTrue:[fd assureExistenceOfPath: 'c'.
		files do:[:fn|
			self copyFileNamed: (fd localNameFor: fn) to: ((fd directoryNamed:'c') localNameFor:(fn allButLast: 2)).
			fd deleteFileNamed: fn]].

	files := (self internalPluginsDirectoryFor: plugin) fileNamesMatching:'*.h'.
	files notEmpty ifTrue:[fd assureExistenceOfPath: 'h'.
		files do:[:fn|
			self copyFileNamed: (fd localNameFor: fn) to: ((fd directoryNamed:'h') localNameFor:(fn allButLast: 2)).
			fd deleteFileNamed: fn]].
	super processFilesForInternalPlugin: plugin
