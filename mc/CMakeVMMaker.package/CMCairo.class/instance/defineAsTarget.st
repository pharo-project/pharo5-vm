generating actions
defineAsTarget
	
	gen puts:
	'add_custom_target(${libName}
		DEPENDS pixman freetype2 "${externalModulesDir}/${libraryFileName}" 
	)'