compiler flags
compilerFlags 
	| releaseFlags |
	
	releaseFlags := self isGenerateForRelease 
		ifTrue: [ self compilerFlagsRelease ]
		ifFalse: [ self compilerFlagsDebug ].
		
	^ String streamContents: [ :stream |
		((self commonCompilerFlags, releaseFlags) collect: #trimBoth as: Set)
			asStringOn: stream 
			delimiter: ' ' ]