patching
versionFor: packageFileName
	^sourceDir
		readOnlyFileNamed: packageFileName
		do: [:fs|
			((MCVersionReader readerClassForFileNamed: fs fullName)
				on: fs fileName: fs fullName)
					version]