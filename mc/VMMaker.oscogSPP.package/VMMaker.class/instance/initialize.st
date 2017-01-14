initialize
initialize
	logger := Transcript.
	inline := true.
	forBrowser := false.
	internalPlugins := SortedCollection new.
	externalPlugins := SortedCollection new.
	platformName := self class machinesDirName.
	is64BitVM := Smalltalk wordSize == 8.
	interpreterClassName := Interpreter name.
	optionsDictionary := Dictionary new.
	optionsDictionary at: #BytesPerWord put: Smalltalk wordSize.
	VMStructType voidStructTypeCache