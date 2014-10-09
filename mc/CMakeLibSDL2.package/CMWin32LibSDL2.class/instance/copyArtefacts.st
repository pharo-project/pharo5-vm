generating actions
copyArtefacts 
	gen puts:
'add_custom_command(
	OUTPUT "${externalModulesDir}/${libraryFileName}"
	COMMAND cp "${SDL2LibInstalled}" "${externalModulesDir}"
	COMMAND cp "${SDL2BinInstalled}" "${externalModulesDir}"
	DEPENDS "${SDL2LibInstalled}"
)'