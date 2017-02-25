exports
generateExportsFile
	"Store the exports on the given file"
	| cg contents filePath fileStream |
	filePath := self interpreterExportsFilePath.
	"don't bother endlessly regenerating the example file."
	(internalPlugins isEmpty
	 and: [(filePath includesSubString: 'example')
	 and: [FileDirectory default fileExists: filePath]]) ifTrue:
		[^self].
	cg := self createCodeGenerator.
	cg vmClass: self interpreterClass.
	contents := String streamContents:
		[:s|
		s
			nextPutAll:'/* This is an automatically generated table of all builtin modules in the VM';
			cr;
			next: 3 put: Character space;
			nextPutAll: (cg shortMonticelloDescriptionForClass: cg vmClass);
			cr;
			nextPutAll:' */';
			cr.
		s cr; nextPutAll:'extern sqExport vm_exports[];'.
		s cr; nextPutAll: 'extern sqExport os_exports[];'.
		self internalPluginsDo:[:cls|
			s cr; nextPutAll: 'extern sqExport '; nextPutAll: cls moduleName; nextPutAll:'_exports[];'.
		].
		s cr.

		s cr; nextPutAll:'sqExport *pluginExports[] = {'.
		s crtab; nextPutAll:'vm_exports,'.
		s crtab; nextPutAll: 'os_exports,'.
		self internalPluginsDo:[:cls|
			s crtab; nextPutAll: cls moduleName; nextPutAll:'_exports,'
		].
		s crtab; nextPutAll:'NULL'.
		s cr; nextPutAll:'};'; cr].
	(cg needToGenerateHeader: (FileDirectory baseNameFor: filePath) file: filePath contents: contents) ifTrue:
		[[fileStream := VMMaker forceNewFileNamed: filePath] 
			on: FileDoesNotExistException 
			do:[^self couldNotOpenFile: filePath].
		 fileStream nextPutAll: contents; close]