generating actions
setVariables
	super setVariables.
	
"add include path"
	gen 
		set: #freetype2_includeDir toString: '${installPrefix}/include';
		set: #libraryFileName to: self libraryFileName;
		set: #freetype2_location toString: '${externalModulesDir}/${libraryFileName}';
		set: #ft2config toString: '${libSourcesDir}/builds/unix/config.status';
	 	set: #ft2libInstalled toString: '${installPrefix}/lib/${libraryFileName}'