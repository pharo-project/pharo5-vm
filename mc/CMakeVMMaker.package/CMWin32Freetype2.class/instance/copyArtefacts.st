generating actions
copyArtefacts

	gen puts:
'add_custom_command(
	OUTPUT "${externalModulesDir}/${libraryFileName}"
	COMMAND cp "${ft2libInstalled}" "${externalModulesDir}"
	COMMAND cp "${ft2binInstalled}" "${externalModulesDir}"
	DEPENDS "${ft2libInstalled}"
)'