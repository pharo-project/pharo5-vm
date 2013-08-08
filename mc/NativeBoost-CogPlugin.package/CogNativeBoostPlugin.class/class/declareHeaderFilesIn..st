as yet unclassified
declareHeaderFilesIn: aCCodeGenerator

	({ 
		Linux32PlatformId.
		Mac32PlatformId.
	} includes: PlatformId ) ifTrue: [	
	aCCodeGenerator addHeaderFile: '<dlfcn.h>'
	].
	aCCodeGenerator addHeaderFile: '<setjmp.h>'.

	PlatformId ifNil: [
		self error: 'target platform id is not set!' ]