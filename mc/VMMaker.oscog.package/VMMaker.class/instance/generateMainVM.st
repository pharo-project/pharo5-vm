generate sources
generateMainVM
	"Generate the interp (and optionally the cogit), internal plugins and exports.
	 N.B. generateInterpreterFile *must* preceed generateCogitFile so that
	 the objectMemory and interpreter classes are initialized before the Cogit
	 code is generated."

	self generateInterpreterFile;
		generateCogitFile;
		processFilesForCoreVM;
		generateInternalPlugins;
		generateExportsFile