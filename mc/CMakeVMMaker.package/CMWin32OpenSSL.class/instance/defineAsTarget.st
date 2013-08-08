as yet unclassified
defineAsTarget 
	
	gen puts:
	'add_custom_target(', self buildTarget , '
		DEPENDS 
		"${externalModulesDir}/libeay32.dll"
		"${externalModulesDir}/ssleay32.dll"
	)'
	
		"${externalModulesDir}/${libraryFileName}"
