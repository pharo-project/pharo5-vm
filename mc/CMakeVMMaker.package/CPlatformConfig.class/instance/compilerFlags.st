compiler flags
compilerFlags 
	| releaseFlags |
	
	releaseFlags := self compilerFlagsForGenerationType.
	^ String streamContents: [ :stream |
		((self commonCompilerFlags, releaseFlags) collect: #trimBoth as: Set)
			asStringOn: stream 
			delimiter: ' ' ]