generate sources
generateMainVM
"generate the interp (and optionally the cogit), internal plugins and exports"

	self generateCogitFile;
		generateInterpreterFile;
		processFilesForCoreVM;
		generateInternalPlugins;
		generateExportsFile