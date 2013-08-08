sources management
addSources: aFileNames prefixed: aPrefix

	| names |
	names := aFileNames inject: '' into: [:res :each | res , ' "' , aPrefix, each, '"' ].
	
	self puts: 'list(APPEND sources ', names , ')'