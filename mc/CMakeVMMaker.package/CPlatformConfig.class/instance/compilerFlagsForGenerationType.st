compiler flags
compilerFlagsForGenerationType
	self isGenerateForRelease ifTrue: [ ^ self compilerFlagsRelease ].
	self isGenerateForDebug ifTrue: [ ^ self compilerFlagsDebug ].
	self isGenerateForTrace ifTrue: [ ^ self compilerFlagsTrace ].
	
	self error: 'Unknown generationType ', generationType asString