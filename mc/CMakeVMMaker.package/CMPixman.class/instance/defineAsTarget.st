generating actions
defineAsTarget
	
	gen puts:
	'add_custom_target(${libName}
		DEPENDS libpng "${externalModulesDir}/${libraryFileName}" 
	)'