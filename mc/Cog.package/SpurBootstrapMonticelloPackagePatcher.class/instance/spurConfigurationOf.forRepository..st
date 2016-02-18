configurations
spurConfigurationOf: anMCConfiguration forRepository: repo
	"Answer a copy of anMCConfiguration containing the matching Spur dependencies.
	 If no replacements could be made (because no Spur versions exist) then answer nil."
	| found clone |
	found := false.
	clone := Array streamContents:
				[:s|
				s nextPut: #name; nextPut: (anMCConfiguration name copyReplaceAll: 'update-' with: 'update.spur-');
				 "no location accessor!!"
				  nextPut: #repository; nextPut: {anMCConfiguration repositories first locationWithTrailingSlash allButLast}.
				 anMCConfiguration dependencies do:
					[:dep| | info pkg ver spurVersionName |
					 info := dep versionInfo.
					 ((pkg := self packages
								detect: [:package| package name = dep package name]
								ifNone: []) notNil
					  and: [spurVersionName := (info name
													copyReplaceAll: pkg name
													with: pkg name, '.spur'), '.mcz'.
						 (ver := MCCacheRepository default versionNamed: spurVersionName asMCVersionName) ifNil:
							[ver := repo versionNamed: spurVersionName asMCVersionName].
						 ver notNil])
						ifTrue: [found := true. info := ver info].
					(ver isNil and: [spurVersionName notNil]) ifTrue:
						[Transcript nextPutAll: 'failed to get ', spurVersionName, ' in ', anMCConfiguration name; cr; flush.
						 self error: 'failed to get ', spurVersionName, ' in ', anMCConfiguration name].
					s nextPut: #dependency; nextPut: (MCConfiguration dependencyToArray: (MCVersionDependency package: dep package info: info))]].
	^found ifTrue:
		[MCConfiguration fromArray: clone]