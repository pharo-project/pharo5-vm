generating actions
copyArtefacts

	gen puts:
'add_custom_command(
	OUTPUT "${externalModulesDir}/${libraryFileName}"
	DEPENDS "${ft2libInstalled}"
)'