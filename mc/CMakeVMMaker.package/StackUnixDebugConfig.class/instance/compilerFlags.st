compiler flags
compilerFlags
	^  String streamContents:  [ :stream |
	self commonCompilerFlags asStringOn: stream delimiter: ' '. 
	self compilerFlagsDebug asStringOn: stream delimiter: ' ' ]