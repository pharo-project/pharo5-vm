building
buildConfig: config
	self isDebug
		ifTrue:  [ config generateForDebug ]
		ifFalse: [ config generateForRelease ].
		
	^ config
		generateSources;
		generate
		