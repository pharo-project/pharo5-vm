settings
extraVMSettings: maker
	self architecture
		ifNotNil: [ :arch | maker set: 'CMAKE_OSX_ARCHITECTURES' toString: arch ].
	self setResourceProperties: maker.
