sources management
addSources: aFileNames prefixed: aPrefix

	| names |
	names := aFileNames inject: '' into: [:res :each | res ,  aPrefix, each, ' ' ].
	self append: #LOCAL_SRC_FILES with: names.
