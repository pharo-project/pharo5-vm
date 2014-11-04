sources management
addSources: aFileNames prefixed: aPrefix

	| names temp|
	temp :=  aFileNames collect:[:each | (each copyFrom: (each size - 1)to: each size) = '.c' ifFalse:[each,'.c'] ifTrue:[each]].
	names := temp inject: '' into: [:res :each | res ,  aPrefix, each, ' ' ].
	self append: #LOCAL_SRC_FILES with: names.
