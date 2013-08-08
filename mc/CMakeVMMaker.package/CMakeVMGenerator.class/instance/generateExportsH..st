as yet unclassified
generateExportsH: libs
	| content |
	content := String streamContents: [:str |
	
		str nextPutAll: '/* This is automatically generated file using CVMMaker on ',
			Date current asString, ' ' , Time current asString , ' */'; cr.
		
		str nextPutAll: 
'extern sqExport vm_exports[];
extern sqExport os_exports[];
'.
		libs do: [:each | 
			str nextPutAll: 'extern sqExport ', each ,'_exports [];'; cr ].
		
		str cr; nextPutAll: 'sqExport *pluginExports[] = {
	vm_exports,
	os_exports,
'.

		libs do: [:each | 
			str nextPutAll:  each ,'_exports,'; cr ].
	
		str nextPutAll: 'NULL
};'

	].

	(FileStream forceNewFileNamed: (self buildDir /'sqNamedPrims.h') fullName) nextPutAll: (config fixLineEndsOf: content); close.
	