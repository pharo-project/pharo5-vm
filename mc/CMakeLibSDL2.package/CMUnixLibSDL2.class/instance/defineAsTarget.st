generating actions
defineAsTarget
	gen puts:
'
add_custom_target(${libName} 
	DEPENDS ${externalModulesDir}/${libraryFileName}
			"${externalModulesDir}/libSDL2-2.0.so.0.2.1"
	)
'