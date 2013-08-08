generating actions
defineAsTarget 
	
	gen puts:
	'add_custom_target(', self buildTarget , '
		DEPENDS 
		"${externalModulesDir}/${libraryFileName}"
	)'
	
		"${externalModulesDir}/${libraryFileName}"
