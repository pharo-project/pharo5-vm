accessing
unload
	SmalltalkImage current unloadModule: self libraryName.
	alienHandle := nil.