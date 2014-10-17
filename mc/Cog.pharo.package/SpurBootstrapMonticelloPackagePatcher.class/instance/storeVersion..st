patching
storeVersion: newVersion
	[(MCDirectoryRepository new directory: destDir) storeVersion: newVersion]
		on: FileExistsException
		do: [:ex| ex resume: (ex fileClass forceNewFileNamed: ex fileName)]