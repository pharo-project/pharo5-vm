accessing
compilerFlags 
	| releaseFlags |
	
	releaseFlags := self isGenerateForRelease 
		ifTrue: [ self compilerFlagsRelease ]
		ifFalse: [ self compilerFlagsDebug ].
		
	^String streamContents: [ :stream |
		(self commonCompilerFlags, releaseFlags) asSet
			do: [ :each | stream nextPutAll: each ]
			separatedBy: [ stream space ] ]