patching
versionFor: packageFileName in: directory
	^directory
		readOnlyFileNamed: packageFileName
		do: [:fs|
			((MCVersionReader readerClassForFileNamed: fs fullName)
				on: fs fileName: fs fullName)
					version]