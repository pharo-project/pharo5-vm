generate sources
generateMainVM
	"Generate the interp (and optionally the cogit), internal plugins and exports.
	 N.B. generateInterpreterFile *must* precede generateCogitFile so that
	 the objectMemory and interpreter classes are initialized before the Cogit
	 code is generated."

	self logDateAndTime;
		generateInterpreterFile;
		generateCogitFiles;
		processFilesForCoreVM;
		generateInternalPlugins;
		generateExportsFile;
		logDateAndTime