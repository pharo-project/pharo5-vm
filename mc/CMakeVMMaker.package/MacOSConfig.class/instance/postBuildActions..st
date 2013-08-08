utils
postBuildActions: gen

	" override to add custom rules after all targets is defined "
	
	self write: self fixLibsTemplate toFile: 'fix_libs.cmake'.
	
	
	gen
		set: #bundlePath toString: '${outputDir}/', self executableName, '.app';
		set: #pluginsRelPath toString: '@executable_path/Plugins'.

	gen
		puts: '
		INSTALL(CODE "
			set(externalModulesDir \"${externalModulesDir}\")
			set(bundlePath \"${bundlePath}\")
			set(pluginsRelPath \"${pluginsRelPath}\")
			
			include(fix_libs.cmake)
		")'
			
"					FILE(GLOB_RECURSE bLibs /${externalModulesDir}/*.*)
"