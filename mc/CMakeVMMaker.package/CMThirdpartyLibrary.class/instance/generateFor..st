generating cmake file
generateFor: aVMGenerator

	| libDir stream contents |
	
	vmGen := aVMGenerator.
	
	gen := CMakeGenerator new
		output: (String new writeStream).
	
	libDir := (aVMGenerator thirdpartyDir / self canonicalName) ensureCreateDirectory.

	stream := String new writeStream.
	
	self generate.

	stream nextPutAll: (vmGen config fixLineEndsOf: gen output contents).

	contents := stream contents. 
	
	(self isFile: (libDir asFileReference / gen outputFileName) fullName hasContents: contents) ifFalse: [
		"contents changed, update the file. Because fucking cmake will force rebuild everything if we change its modification date
		without changing its contents"
		(FileStream forceNewFileNamed: (libDir asFileReference / gen outputFileName)) nextPutAll: contents; close.
		].
	

	vmGen addSubdirectory:  vmGen thirdpartyDirName , '/' , self canonicalName.
	self defineGlobalTargets.
	